(setq projectile-switch-project-action 'projectile-dired)
(setq projectile-enable-caching t)

(defadvice projectile-on (around exlude-tramp activate)
    (unless  (--any? (and it (file-remote-p it))
        (list
            (buffer-file-name)
            list-buffers-directory
            default-directory))
    ad-do-it))
(setq projectile-completion-system 'helm)
(projectile-global-mode)

(provide 'projectile-setup)
