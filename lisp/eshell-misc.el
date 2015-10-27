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

(display-buffer "*ooo*" t)
(switch-to-buffer-other-window "*ooo*")

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

