
(defun eshell-execute-command (esh-buffer-name text)
  "Execute command in eshell"
  (interactive)
  (require 'eshell)
  (let ((buf (current-buffer)))
    (unless (get-buffer esh-buffer-name)
      (eshell))
    (display-buffer esh-buffer-name t)
    (switch-to-buffer-other-window esh-buffer-name)
    (end-of-buffer)
    (eshell-kill-input)
    (insert text)
    (eshell-send-input)
    (end-of-buffer)
    (switch-to-buffer-other-window buf)))


(defun run-blackpearl-wl-command-50x (branchname)
  (interactive "sEnter branch name: ")
  (shell-with-name "*eshell-wl-interactive*")
  (eshell-execute-command "*eshell-wl-interactive*" (format "cd /blackpearl:/home/mico/src/wl-interactive/; node app.js -b %s -e 50X --dev" branchname)))


