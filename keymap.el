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
(define-key isearch-mode-map "\C-r" 'isearch-yank-region)

(global-set-key (kbd "M-0") 'er/expand-region)

(global-set-key (kbd "M-=") 'hs-show-block)
(global-set-key (kbd "M-+") 'hs-show-all)
(global-set-key (kbd "M--") 'hs-hide-block)
(global-set-key (kbd "M-_") 'hs-hide-all)

;; todo - move these into separate file
(defun toggle-kbd-macro-recording-on ()
  "One-key keyboard macros: turn recording on."
  (interactive)
  (define-key global-map (this-command-keys)
    'toggle-kbd-macro-recording-off)
  (start-kbd-macro nil))

(defun toggle-kbd-macro-recording-off ()
  "One-key keyboard macros: turn recording off."
  (interactive)
  (define-key global-map (this-command-keys)
    'toggle-kbd-macro-recording-on)
  (end-kbd-macro))


(global-set-key (kbd "C-,") 'toggle-kbd-macro-recording-on)
(global-set-key (kbd "C-.") 'call-last-kbd-macro)
(global-set-key (kbd "C-k") 'kill-whole-line)

(global-set-key (kbd "C-l") 'goto-line)
;; org-mode
(global-set-key (kbd "C-k") 'org-table-kill-row)
(global-set-key (kbd "C-c M-p") (lambda() (interactive) (find-file "~/Documents/pomodoro.org")))

(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

;; mapping to caps/control as C and cmd as alt(meta)
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'control)
  (setq mac-command-modifier 'meta))
