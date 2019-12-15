(delete-selection-mode)
;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-always-indent 'complete)
(setq indent-line-function 'insert-tab)

;; enable upcase
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

;; improve scrolling
(setq jit-lock-defer-time 0)
(setq fast-but-imprecise-scrolling t)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
