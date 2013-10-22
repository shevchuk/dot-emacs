;; Move to beginning/ending of line
(defconst ergoemacs-move-beginning-of-line-key	(kbd "M-H"))
(defconst ergoemacs-move-end-of-line-key	(kbd "M-L"))
(defconst ergoemacs-delete-window (kbd "M-3"))
(defconst ergoemacs-delete-other-windows (kbd "M-4"))
(defconst ergoemacs-split-window-below (kbd "M-8"))
(defconst ergoemacs-split-window-right (kbd "M-9"))

(define-key ergoemacs-keymap ergoemacs-move-end-of-line-key 'move-end-of-line)
(define-key ergoemacs-keymap ergoemacs-move-beginning-of-line-key 'move-beginning-of-line)
(define-key ergoemacs-keymap ergoemacs-split-window-below 'split-window-below)
(define-key ergoemacs-keymap ergoemacs-split-window-right 'split-window-right)
(define-key ergoemacs-keymap ergoemacs-delete-window 'delete-window)
(define-key ergoemacs-keymap ergoemacs-delete-other-windows 'delete-other-windows)

;; editor
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(global-set-key (kbd "M-0") 'er/expand-region)

;; mapping to caps/control as C and cmd as alt(meta)
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'control)
  (setq mac-command-modifier 'meta))
