(delete-selection-mode)
;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

(setq-default js-indent-level 2)
(setq-default typescript-indent-level 2)

(setq tab-always-indent 'complete)
(setq indent-line-function 'insert-tab)

;; enable upcase
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

(ctrlf-mode +1)

;; improve scrolling
(setq jit-lock-defer-time 0)
(setq fast-but-imprecise-scrolling t)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time
(scroll-bar-mode 0)
(scroll-lock-mode t)

(with-eval-after-load 'smartparens
  (require 'smartparens-config))

(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;(set-frame-font "Hack 11")

;(add-to-list 'default-frame-alist
;             '(font . "Hack 11"))

(set-frame-font "Hack 11")

(add-to-list 'default-frame-alist
             '(font . "Hack 11"))

;; Use font-lock everywhere.
(global-font-lock-mode t)

;; We have CPU to spare; highlight all syntax categories.
(setq font-lock-maximum-decoration t)

(setq-default cursor-type 'box) ;; bar
;;(blink-cursor-mode 2)
(set-cursor-color "#FF00D4") ; pink

(progn
 ;; Make whitespace-mode with very basic background coloring for whitespaces.
  ;; http://ergoemacs.org/emacs/whitespace-mode.html
  (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

  ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
  (setq whitespace-display-mappings
        ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
        '(
          (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
          (newline-mark 10 [8629 10]) ; LINE FEED,
          (tab-mark 9 [9655 9] [92 9]) ; tab
          )))

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'vue-mode)
  (flycheck-add-mode 'javascript-eslint 'vue-html-mode)
  (flycheck-add-mode 'javascript-eslint 'css-mode))

(add-to-list 'auto-mode-alist '("\\.ksy$" . yaml-mode))

(provide 'editor)
