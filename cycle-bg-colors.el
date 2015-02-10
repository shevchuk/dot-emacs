(setq left-cycle-bg-colors nil)
(defun cycle-bg-colors ()
  (interactive)
  (if (eq left-cycle-bg-colors nil)
      (setq left-cycle-bg-colors cycle-bg-colors))
  (set-background-color (pop left-cycle-bg-colors))
  (sleep-for 1))

(global-set-key (kbd "C-5") 'cycle-bg-colors)

(global-set-key (kbd "C-6") 'set-random-theme-for-current-buffer)

(defun set-random-theme-for-current-buffer()
  (interactive)
  (setq th (car (nth (random (length color-themes)) color-themes)))
  (message "Setting current buffer theme to: %s " th)
  (color-theme-buffer-local th))

(provide 'cycle-bg-colors)
