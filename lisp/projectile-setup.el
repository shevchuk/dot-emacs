(setq projectile-switch-project-action 'projectile-dired)
(setq projectile-enable-caching t)

(defadvice projectile-on (around exlude-tramp activate)
    (unless  (--any? (and it (file-remote-p it))
        (list
            (buffer-file-name)
            list-buffers-directory
            default-directory))
    ad-do-it))
;; Projectile 3.0+ removed the dedicated 'helm completion system value.
;; Helm is now used through `completing-read' by enabling `helm-mode'.
(setq projectile-completion-system 'default)
(helm-mode 1)
(projectile-mode)

(provide 'projectile-setup)
