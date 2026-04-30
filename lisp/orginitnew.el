(defun my/org-mode-setup-monospace-tables ()
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch))

(add-hook 'org-mode-hook #'my/org-mode-setup-monospace-tables)

(provide 'orginitnew)
