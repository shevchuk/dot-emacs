;; no startup msg
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;; disable top menu
(menu-bar-mode -99)

(require 'uniquify)
(setq
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

(setq transient-mark-mode t)
(tool-bar-mode -1)

;; this is current color theme
;(standard-themes-load-dark)
;(modus-themes-select 'modus-vivendi-deuteranopia)
(modus-themes-select 'modus-vivendi-tinted)
(load-theme 'airline-violet)

;; to make recent files section work in the dashboard, enabled recentf
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)
                        (projects . 5)
                        (agenda . 5)
                        (registers . 5)))

;; Content is not centered by default. To center, set
(setq dashboard-center-content t)
(setq dashboard-set-heading-icons t)
(setq dashboard-set-file-icons t)

(dashboard-setup-startup-hook)

;(setq-default cycle-bg-colors '("#111122" "#112211" "#221122" "#112222" "#00587b" "#004b15"))
;(require 'cycle-bg-colors)

                                        ;(powerline-nano-theme)

(add-hook 'org-mode-hook (lambda ()
                                        ;(org-modern-mode)
                           (org-indent-mode)
                           (setq buffer-face-mode-face '(:family "Carlito" :height 140))
                           (lambda () (face-remap-add-relative 'default :family "Monospace"))
                           (visual-line-mode)
                           (buffer-face-mode)))
(provide 'ui-setup)
