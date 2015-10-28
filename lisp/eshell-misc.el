(setq eshell-history-size nil)

(add-hook 'eshell-mode-hook
          #'(lambda ()
              (face-remap-add-relative 'mode-line '((:foreground "ivory" :background "chartreuse4") mode-line))
              (setq pcomplete-cycle-completions nil)))

;;(eshell-command "export LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH")

(defadvice pcomplete (around avoid-remote-connections activate)
   (let ((file-name-handler-alist (copy-alist file-name-handler-alist)))
     (setq file-name-handler-alist
           (delete (rassoc 'tramp-completion-file-name-handler
                           file-name-handler-alist) file-name-handler-alist))
     ad-do-it))

(defun run-shell-command (buffer-name sh-command)
  (interactive "sBuffer name: \nsSh: ")
  (let ((buffer-name-formatted (format "*%s*" buffer-name)))
    (shell-with-name buffer-name-formatted)
    (eshell-execute-command buffer-name-formatted sh-command)))

(defun eshell-here ()
  (interactive)
  (let ((buffer-name-formatted (format "*eshell:%s*" default-directory)))
    (shell-with-name buffer-name-formatted)))

(defun eshell-execute-command (esh-buffer-name text)
  "Execute command in eshell"
  (interactive)
  (require 'eshell)
  (let ((buf (current-buffer)))
    (unless (get-buffer esh-buffer-name)
      (eshell))
    (display-buffer esh-buffer-name t)
    ;;(switch-to-buffer-other-window esh-buffer-name)
    (end-of-buffer)
    (eshell-kill-input)
    (insert text)
    (eshell-send-input)
    (end-of-buffer)
    ;;(switch-to-buffer-other-window buf)
    ))
	
(setq eshell-history-size 1024)
(setq eshell-prompt-regexp "^[^#$]*[#$] ")

(load "em-hist")           ; So the history vars are defined
(if (boundp 'eshell-save-history-on-exit)
    (setq eshell-save-history-on-exit t)) ; Don't ask, just save
;(message "eshell-ask-to-save-history is %s" eshell-ask-to-save-history)
(if (boundp 'eshell-ask-to-save-history)
    (setq eshell-ask-to-save-history 'always)) ; For older(?) version
;(message "eshell-ask-to-save-history is %s" eshell-ask-to-save-history)

(defun eshell/ef (fname-regexp &rest dir) (ef fname-regexp default-directory))


;;; ---- path manipulation

(defun pwd-repl-home (pwd)
  (interactive)
  (let* ((home (expand-file-name (getenv "HOME")))
   (home-len (length home)))
    (if (and
   (>= (length pwd) home-len)
   (equal home (substring pwd 0 home-len)))
  (concat "~" (substring pwd home-len))
  pwd)))

(defun curr-dir-git-branch-string (pwd)
  "Returns current git branch as a string, or the empty string if
PWD is not in a git repo (or the git command is not found)."
  (interactive)
  (when (and (eshell-search-path "git")
             (locate-dominating-file pwd ".git"))
    (let ((git-output (shell-command-to-string (concat "cd " pwd " && git branch | grep '\\*' | sed -e 's/^\\* //'"))))
      (propertize (concat "[git:"
              (if (> (length git-output) 0)
                  (substring git-output 0 -1)
                "(no branch)")
              "]") 'face `(:foreground "green"))
      )))

(defun curr-dir-hg-branch-string (pwd)
  "Returns current hg branch as a string, or the empty string if
PWD is not in a hg repo (or the hg command is not found)."
  (interactive)
  (when (and (eshell-search-path "hg")
             (locate-dominating-file pwd ".hg"))
    (let ((hg-output (shell-command-to-string (concat "cd " pwd " && hg branch | sed -e 's/^//'"))))
      (propertize (concat "[hg:"
              (if (> (length hg-output) 0)
                  (substring hg-output 0 -1)
                "(no branch)")
              "]") 'face `(:foreground "green"))
      )))

(setq eshell-prompt-function
      (lambda ()
        (concat
         (propertize ((lambda (p-lst)
            (if (> (length p-lst) 3)
                (concat
                 (mapconcat (lambda (elm) (if (zerop (length elm)) ""
                                            (substring elm 0 1)))
                            (butlast p-lst 3)
                            "/")
                 "/"
                 (mapconcat (lambda (elm) elm)
                            (last p-lst 3)
                            "/"))
              (mapconcat (lambda (elm) elm)
                         p-lst
                         "/")))
          (split-string (pwd-repl-home (eshell/pwd)) "/")) 'face `(:foreground "yellow"))
         (or (curr-dir-hg-branch-string (eshell/pwd)))
         (or (curr-dir-git-branch-string (eshell/pwd)))
         (propertize "# " 'face 'default))))

(setq eshell-highlight-prompt nil)
