(deftheme aoc-theme
  "A color theme with the style of Advent of Code for org-mode.")

(let ((background "#0f0f23")
      (foreground "#cccccc")
      (red "#ff0000")
      (green "#009900")
      (blue "#0000ff")
      (cyan "#00ffff")
      (magenta "#ff00ff")
      (yellow "#ffff66"))
  (custom-theme-set-faces
   'aoc-theme
   `(default ((t (:background ,background :foreground ,foreground))))
   `(cursor ((t (:background ,yellow :foreground ,background))))
   `(region ((t (:background ,magenta :foreground ,background))))
   `(highlight ((t (:background ,blue :foreground ,background))))

   ;; org-mode faces
   `(org-level-1 ((t (:foreground ,green :height 1.5))))
   `(org-level-2 ((t (:foreground ,yellow :height 1.4))))
   `(org-level-3 ((t (:foreground ,cyan :height 1.3))))
   `(org-level-4 ((t (:foreground ,magenta :height 1.2))))
   `(org-level-5 ((t (:foreground ,blue :height 1.1))))
   `(org-document-title ((t (:foreground ,green :height 1.5 :underline t))))
   `(org-document-info ((t (:foreground ,green :height 1.2))))
   `(org-document-info-keyword ((t (:foreground ,green :height 1.0))))
   `(org-meta-line ((t (:foreground ,green :height 1.0))))
   `(org-block-begin-line ((t (:foreground ,green :height 1.0))))
   `(org-block-end-line ((t (:foreground ,green :height 1.0))))
   `(org-code ((t (:foreground ,green))))
   `(org-verbatim ((t (:foreground ,green))))
   `(org-table ((t (:foreground ,green))))
   `(org-block ((t (:foreground ,green))))
   `(org-block-background ((t (:background ,background))))
   `(org-quote ((t (:foreground ,green :slant italic))))
   `(org-date ((t (:foreground ,green :underline t))))
   `(org-link ((t (:foreground ,green :underline t))))
   `(org-special-keyword ((t (:foreground ,green))))
   `(org-tag ((t (:foreground ,green))))
   `(org-checkbox ((t (:foreground ,green))))
   `(org-ellipsis ((t (:foreground ,green))))
   `(org-footnote ((t (:foreground ,green))))
   `(org-formula ((t (:foreground ,green))))
   `(org-list-dt ((t (:foreground ,green))))
   `(org-todo ((t (:foreground ,green :weight bold))))
   `(org-done ((t (:foreground ,green :weight bold))))
   `(org-warning ((t (:foreground ,red :weight bold))))
   `(org-agenda-structure ((t (:foreground ,green))))
   `(org-agenda-date ((t (:foreground ,green))))
   `(org-agenda-date-weekend ((t (:foreground ,green))))
   `(org-agenda-date-today ((t (:foreground ,green :weight bold))))
   `(org-agenda-done ((t (:foreground ,green))))
   `(org-scheduled ((t (:foreground ,green))))
   `(org-scheduled-today ((t (:foreground ,green))))
   `(org-scheduled-previously ((t (:foreground ,red))))
   `(org-upcoming-deadline ((t (:foreground ,red))))
   `(org-time-grid ((t (:foreground ,green))))
   `(org-latex-and-related ((t (:foreground ,green))))

   `(mode-line ((t (:foreground ,background :background ,green :box nil))))
   `(mode-line-inactive ((t (:foreground ,background :background ,green :box nil))))

   ;; font-lock
   `(font-lock-builtin-face ((t (:foreground ,green))))
   `(font-lock-comment-face ((t (:foreground ,green :slant italic))))
   `(font-lock-constant-face ((t (:foreground ,green))))
   `(font-lock-function-name-face ((t (:foreground ,green))))
   `(font-lock-keyword-face ((t (:foreground ,green))))
   `(font-lock-string-face ((t (:foreground ,green))))
   `(font-lock-type-face ((t (:foreground ,green))))
   `(font-lock-variable-name-face ((t (:foreground ,green))))
   `(font-lock-warning-face ((t (:foreground ,red :weight bold))))

   ;; info
   `(info-node ((t (:foreground ,green :slant italic :weight bold))))
   `(info-xref ((t (:foreground ,green :underline t))))
   `(info-xref-visited ((t (:foreground ,green :underline t :slant italic))))

   ;; show-paren-mode
   `(show-paren-match ((t (:background ,green :foreground ,background))))
   `(show-paren-mismatch ((t (:background ,red :foreground ,background))))

   ;; ido-mode
   `(ido-subdir ((t (:foreground ,green))))
   `(ido-first-match ((t (:foreground ,green :weight bold))))
   `(ido-only-match ((t (:foreground ,green))))
   `(ido-indicator ((t (:foreground ,green :background ,background))))
   `(ido-virtual ((t (:foreground ,green))))

   ;; linum-mode
   `(linum ((t (:foreground ,green :background ,background))))

   ;; hl-line-mode
   `(hl-line ((t (:background ,blue :foreground ,background))))

   ;; whitespace-mode
   `(whitespace-space ((t (:foreground ,green :background ,background))))
   `(whitespace-hspace ((t (:foreground ,green :background ,background))))

      ;; whitespace-mode
   `(whitespace-space ((t (:foreground ,green :background ,background))))
   `(whitespace-hspace ((t (:foreground ,green :background ,background))))
   `(whitespace-tab ((t (:foreground ,green :background ,background))))
   `(whitespace-newline ((t (:foreground ,green :background ,background))))
   `(whitespace-trailing ((t (:foreground ,red :background ,background :weight bold))))
   `(whitespace-line ((t (:foreground ,red :background ,background :weight bold))))

   ;; rainbow-delimiters
   `(rainbow-delimiters-depth-1-face ((t (:foreground ,green))))
   `(rainbow-delimiters-depth-2-face ((t (:foreground ,yellow))))
   `(rainbow-delimiters-depth-3-face ((t (:foreground ,cyan))))
   `(rainbow-delimiters-depth-4-face ((t (:foreground ,magenta))))
   `(rainbow-delimiters-depth-5-face ((t (:foreground ,blue))))
   `(rainbow-delimiters-depth-6-face ((t (:foreground ,green))))
   `(rainbow-delimiters-depth-7-face ((t (:foreground ,yellow))))
   `(rainbow-delimiters-depth-8-face ((t (:foreground ,cyan))))
   `(rainbow-delimiters-depth-9-face ((t (:foreground ,magenta))))
   `(rainbow-delimiters-depth-10-face ((t (:foreground ,blue))))
   `(rainbow-delimiters-depth-11-face ((t (:foreground ,green))))
   `(rainbow-delimiters-depth-12-face ((t (:foreground ,yellow))))

   ;; custom
   `(custom-variable-tag ((t (:foreground ,green :weight bold))))
   `(custom-group-tag ((t (:foreground ,green :weight bold))))
   `(custom-state ((t (:foreground ,green))))
   ))


;(provide-theme 'aoc-theme)
