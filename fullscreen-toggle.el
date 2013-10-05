(defun fs/toggle-save-win-conf ()
  (window-configuration-to-register 'win-conf-tmp))

(defun fs/toggle-restore-win-conf ()
  (jump-to-register 'win-conf-tmp))

(setq fs/marker nil)

(defun fs/toggle-win-conf (after-expand-function)
  (if (eq fs/marker nil)
      (progn
	(message "Expanding current window")
	(fs/toggle-save-win-conf)
	(funcall after-expand-function)
	(setq fs/marker t))
    (progn 
      (message "Restoring windows view")
      (fs/toggle-restore-win-conf)
      (setq fs/marker nil))))

;;;###autoload
(defun fs/save-windows-state-and-expand ()
  (interactive)
  (progn
	(message "Expanding current window")
	(fs/toggle-save-win-conf)
	(delete-other-windows)))

;;;###autoload
(defun fs/restore-windows-state ()
  (interactive)
  (progn 
      (message "Restoring windows view")
      (fs/toggle-restore-win-conf)))

;;;###autoload
(defun fs/toggle-fullscreen ()
  "Toggles fullscreen mode.
First call will expand current window.
Second call will restore previous state."
  (interactive)
  (fs/toggle-win-conf (function delete-other-windows)))

;;(global-set-key (kbd "C-,") 'fs/save-windows-state-and-expand)
;;(global-set-key (kbd "C-.") 'fs/restore-windows-state)
(global-set-key (kbd "C-m") 'fs/toggle-fullscreen)

(provide 'fullscreen-toggle)

