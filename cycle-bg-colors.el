(setq left-cycle-bg-colors nil)
(defun cycle-bg-colors ()
  (interactive)
  (if (eq left-cycle-bg-colors nil)
      (setq left-cycle-bg-colors cycle-bg-colors))
  (set-background-color (pop left-cycle-bg-colors)))

(global-set-key (kbd "C-5") 'cycle-bg-colors)

(provide 'cycle-bg-colors)
