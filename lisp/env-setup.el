;(when (memq window-system '(mac ns x))
;  (exec-path-from-shell-initialize))

(setenv "PATH"
        (concat "/bin:"
                (concat (getenv "HOME") "/.nvm:")
                "/home/mico/.nvm/versions/node/v12.18.0/bin/:"
                (getenv "PATH")))

(setenv "NVM_DIR" (concat (getenv "HOME") "/.nvm"))

; NODE_OPTIONS=--openssl-legacy-provider
(setenv "NODE_OPTIONS" "--openssl-legacy-provider")

(provide 'env-setup)
