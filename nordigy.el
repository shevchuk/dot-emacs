(defun nordigy-eshell-execute-command (esh-buffer-name text)
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


(defun nordigy-run-blackpearl-wl-command-50x (branchname)
  (interactive "sEnter branch name: ")
  (nordigy-run-blackpearl-wl-command-non-interactive branchname "50X"))

(defun nordigy-run-blackpearl-wl-command (branchname environment)
  (interactive "sEnter branch name: \nsEnter environment name: ")
  (nordigy-run-blackpearl-wl-command-non-interactive branchname environment))

(defun nordigy-get-web-launcher-eshell-buffer-name (branchname environment)
  (concat "*eshell-web-launcher-" branchname "-" environment "*"))

(defun nordigy-run-blackpearl-wl-command-non-interactive (branchname environment)
  (let ((shell-buffer-name (nordigy-get-web-launcher-eshell-buffer-name branchname environment)))
    (shell-with-name shell-buffer-name)
  (eshell-execute-command shell-buffer-name (format "cd /blackpearl:/home/mico/src/wl-interactive/; node app.js -b %s -e %s --dev" branchname environment))))

(defun nordigy-get-compass-buffer-name (branchname)
  (concat "*eshell-compass-" branchname "*"))

(defun nordigy-run-compass-in (branchname)
  (interactive "sEnter branch name:")
  (shell-with-name (nordigy-get-compass-buffer-name branchname))
  (eshell-execute-command (nordigy-get-compass-buffer-name branchname) (format "cd /blackpearl:/home/mico/src/%s/utils/compass; sh compass-compile.bash" branchname)))
