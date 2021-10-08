(diredp-toggle-find-file-reuse-dir 1)

(require 'dired-x)
(setq-default dired-omit-files-p nil) ; Buffer-local variable
(setq-default dired-details-hidden-string "--- ")
(dired-details-install)
(setq dired-dwim-target t)

(provide 'dired-settings)
