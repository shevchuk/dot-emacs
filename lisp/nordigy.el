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

(defun nordigy-run-localhost-wl-command-ams (branchname)
  (interactive "sEnter branch name: ")
  (nordigy-run-localhost-wl-command-non-interactive branchname "AMS"))

(defun nordigy-run-localhost-wl-command-50x (branchname)
  (interactive "sEnter branch name: ")
  (nordigy-run-localhost-wl-command-non-interactive branchname "50X"))

(defun nordigy-run-blackpearl-wl-command (branchname environment)
  (interactive "sEnter branch name: \nsEnter environment name: ")
  (nordigy-run-blackpearl-wl-command-non-interactive branchname environment))

(defun nordigy-run-localhost-wl-command (branchname environment)
  (interactive "sEnter branch name: \nsEnter environment name: ")
  (nordigy-run-localhost-wl-command-non-interactive environment))

(defun nordigy-get-web-launcher-eshell-buffer-name (branchname environment)
  (concat "*eshell-web-launcher-" branchname "-" environment "*"))

(defun nordigy-run-blackpearl-wl-command-non-interactive (branchname environment)
  (let ((shell-buffer-name (nordigy-get-web-launcher-eshell-buffer-name branchname environment)))
    (shell-with-name shell-buffer-name)
    (nordigy-eshell-execute-command shell-buffer-name (format "cd /blackpearl:/home/mico/src/wl-interactive/; node app.js -b %s -e %s --dev" branchname environment))))

(defun nordigy-run-localhost-wl-command-non-interactive (branchname environment)
  (let ((shell-buffer-name (nordigy-get-web-launcher-eshell-buffer-name branchname environment)))
    (shell-with-name shell-buffer-name)
    (nordigy-eshell-execute-command shell-buffer-name (format "cd ~/src/wl-interactive/; node app.js -b %s -e %s --dev" branchname environment))))

(defun nordigy-connect-via-ssh ()
  (interactive)
  (let ((shell-buffer-name "*connect-to-vfs*"))
    (shell-with-name shell-buffer-name)
    (nordigy-eshell-execute-command shell-buffer-name (format "~/connect_vfs.sh"))))

(defun nordigy-get-compass-buffer-name (branchname)
  (concat "*eshell-compass-" branchname "*"))

(defun nordigy-run-compass-in (branchname)
  (interactive "sEnter branch name:")
  (shell-with-name (nordigy-get-compass-buffer-name branchname))
  (nordigy-eshell-execute-command (nordigy-get-compass-buffer-name branchname) (format "cd /blackpearl:/home/mico/src/%s/utils/compass; sh compass-compile.bash" branchname)))

(defun nordigy-get-test-name ()
  "Gets a path to a current script + name without extensions"
  (interactive)
  (let ((script-name 
         (car (split-string
          (car (last 
                (split-string (or load-file-name buffer-file-name) "/"))) "."))))
        (message (concat  
         (file-name-directory (or load-file-name buffer-file-name))
         script-name
         ))))


;; new functions
(defun run-weblauncher ()
  (interactive)
  (let ((buffer-name-formatted (format "*%s*" "weblauncher")))
    (shell-with-name buffer-name-formatted)
    (eshell-execute-command buffer-name-formatted "cd ~/src/weblauncher; node index.js")))

(defun run-test ()
  "run a command on the current file and revert the buffer"
  (interactive)
  (setq environments  (list "DEV-FTF-AMS" "DEV-FT2-AMS" "DEV-FT2-AMS-local" "DEV-ATT-50X" "DEV-FTR-AMS" "DEV-FTR-AMS-tds01"))
  (setq env (ido-completing-read "Select environment? " environments))
  (run-shell-command (format "webtest:%s" (car (last (split-string buffer-file-name "/"))))
   (format "node %s --debug -e %s"
           (shell-quote-argument (replace-regexp-in-string "/src/tests/src/" "/src/tests/dist/" (buffer-file-name)))
           env
           ))
  (revert-buffer t t t))

(defun run-vpn ()
  "run a command on the current file and revert the buffer"
  (interactive)
  (run-shell-command "vpn"
   "sudo openconnect --juniper https://vpn.nordigy.ru/dana-na/auth/url_2/welcome.cgi")
  (revert-buffer t t t))

(global-set-key (kbd "<f8> e") 'run-test)

(defun run-babel-watch ()
  "run a command on the current file and revert the buffer"
  (interactive)
  (run-shell-command "babel-watch"
   "npm run watch")
  (revert-buffer t t t))

(defun run-vnc ()
  "run vinagre to automation host"
  (interactive)
  (run-shell-command "vnc ftw01-t01-tds01.lab.nordigy.ru"
                     "vinagre ftw01-t01-tds01.lab.nordigy.ru")
  (revert-buffer t t t))
 
(global-set-key (kbd "<f8> w") 'run-babel-watch)

(defun copy-current-filepath-to-clipboard ()
  "Show the full path file name in the minibuffer and copy it to clipboard"
  (interactive)
  (kill-new (buffer-file-name))
  (message (buffer-file-name)))


(defun copy-current-testpath-to-clipboard ()
  "Show the full path file name in the minibuffer and copy it to clipboard"
  (interactive)
  (kill-new (replace-regexp-in-string "/home/mico/src/tests/src/tests" "" (buffer-file-name)))
  (message (replace-regexp-in-string "/home/mico/src/tests/src/tests" "" (buffer-file-name))))

