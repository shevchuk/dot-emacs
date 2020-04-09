(defun copy-current-projectpath-to-clipboard ()
  "Show the full path file name in the minibuffer and copy it to clipboard"
  (interactive)
  (kill-new (replace-regexp-in-string (projectile-project-root) "" (buffer-file-name)))
  (message (replace-regexp-in-string (projectile-project-root) "" (buffer-file-name))))

(defun copy-current-fullpath-to-clipboard ()
  "Show the full path file name in the minibuffer and copy it to clipboard"
  (interactive)
  (kill-new (buffer-file-name))
  (message (buffer-file-name)))

(provide 'project)
