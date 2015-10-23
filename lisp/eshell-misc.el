(setq eshell-history-size nil)

(add-hook 'eshell-mode-hook
          #'(lambda ()
              (face-remap-add-relative 'mode-line '((:foreground "ivory" :background "chartreuse4") mode-line))
              (setq pcomplete-cycle-completions nil)
              (eshell-command "export LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH")))

(defadvice pcomplete (around avoid-remote-connections activate)
   (let ((file-name-handler-alist (copy-alist file-name-handler-alist)))
     (setq file-name-handler-alist
           (delete (rassoc 'tramp-completion-file-name-handler
                           file-name-handler-alist) file-name-handler-alist))
     ad-do-it))

(defun eshell-with-name (name)
  (interactive "sEnter eshell buffer name:")
  (require 'eshell)
  (with-current-buffer
      (eshell-mode t)
    (rename-buffer name)))

(defun eshell-with-name-2 (esh-buffer-name)
  "Execute command in eshell"
  (interactive "sEnter eshell buffer name:")
  (require 'eshell)
  (let ((buf (current-buffer)))
    (unless (get-buffer esh-buffer-name)
      (eshell))
    (display-buffer esh-buffer-name t)
    (switch-to-buffer-other-window esh-buffer-name)
    (end-of-buffer)
    (switch-to-buffer-other-window buf)))

