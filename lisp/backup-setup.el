;; backup tuning
;; Store backups and auto-saved files in TEMPORARY-FILE-DIRECTORY (which defaults to /tmp on Unix), instead of in the same directory as the file.
(setq make-backup-files nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(provide 'backup-setup)
