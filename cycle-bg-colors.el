(setq cycle-bg-colors-left-colors nil)
(defun cycle-bg-colors ()
  (interactive)
  (if (eq cycle-bg-colors-left-colors nil)
      (setq left-cycle-bg-colors-left-colors cycle-bg-colors))
  (set-background-color (pop cycle-bg-colors-left-colors)))

(global-set-key (kbd "C-5") 'cycle-bg-colors)

(provide 'cycle-bg-colors)
