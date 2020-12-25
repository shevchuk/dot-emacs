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

(load-theme 'modus-operandi)
(load-theme 'airline-silver)
(require 'modeline)

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

(setq-default cycle-bg-colors '("#111122" "#112211" "#221122" "#112222" "#00587b" "#004b15"))
(require 'cycle-bg-colors)

                                        ;(powerline-nano-theme)
(load-theme 'airline-silver t)
(provide 'ui-setup)
