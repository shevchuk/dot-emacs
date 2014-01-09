(defun copy-current-filepath-to-clipboard ()
  "Show the full path file name in the minibuffer and copy it to clipboard"
  (interactive)
  (kill-new (buffer-file-name))
  (message (buffer-file-name)))
