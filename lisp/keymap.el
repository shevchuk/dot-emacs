;; Move to beginning/ending of line

(defconst ergoemacs-move-beginning-of-line-key	(kbd "M-H"))
(defconst ergoemacs-move-end-of-line-key	(kbd "M-L"))
(defconst ergoemacs-delete-window (kbd "M-2"))
(defconst ergoemacs-delete-other-windows (kbd "M-1"))
(defconst ergoemacs-split-window-below (kbd "M-8"))
(defconst ergoemacs-split-window-right (kbd "M-9"))

(defconst ergoemacs-isearch-forward-key	(kbd "M-;"))
(defconst ergoemacs-isearch-backward-key (kbd "M-:"))

(global-unset-key (kbd "M-c"))
(global-set-key (kbd "M-x") 'kill-region)
(global-set-key (kbd "M-v") 'yank)
(global-set-key (kbd "<f2>") 'save-buffer)

(defun copy-line (arg)
      "Copy lines (as many as prefix argument) in the kill ring"
      (interactive "p")
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position (+ 1 arg)))
      (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(global-set-key (kbd "M-c") 'kill-ring-save)
(global-set-key (kbd "M-C") 'copy-line)
(global-set-key (kbd "M-K") 'kill-whole-line)

;;(global-set-key [remap kill-ring-save] 'easy-kill)
(global-set-key (kbd "M-e") 'backward-kill-word)
(global-set-key (kbd "<mouse-2>") 'x-clipboard-yank)
(global-set-key (kbd "C-f") 'isearch-forward)

(global-set-key (kbd "M-3") 'delete-other-windows)                                                
(global-set-key (kbd "M-8") 'split-window-below)
(global-set-key (kbd "M-9") 'split-window-right)
(global-set-key (kbd "M-s") 'other-window)

(global-set-key (kbd "M-p") 'ace-window)

(define-key minibuffer-local-map (kbd "M-r") 'kill-word) ; was previous-matching-history-element.
(define-key minibuffer-local-map (kbd "M-s") 'other-window) ; was nest-matching-history-element

;;(DEFINE-key ergoemacs-keymap ergoemacs-move-end-of-line-key 'move-end-of-line)
;;(define-key ergoemacs-keymap ergoemacs-move-beginning-of-line-key 'move-beginning-of-line)
;;(define-key ergoemacs-keymap ergoemacs-split-window-below 'split-window-below)
;;(define-key ergoemacs-keymap ergoemacs-split-window-right 'split-window-right)
;;(define-key ergoemacs-keymap ergoemacs-delete-window 'delete-window)
;;(define-key ergoemacs-keymap ergoemacs-delete-other-windows 'delete-other-windows)

(global-set-key (kbd "C-x C-j") 'dired-jump)

;; editor
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(define-key isearch-mode-map "\C-r" 'isearch-yank-region)

(global-set-key (kbd "C-b") 'bookmark-set)
(global-set-key (kbd "M-b") 'bookmark-jump)

(global-set-key (kbd "\C-r") 'isearch-backward)
(global-set-key (kbd "<f7>") 'isearch-forward)

(global-set-key (kbd "M-0") 'er/expand-region)
(global-set-key (kbd "<f4>") 'ido-find-file)

(add-hook 'hs-minor-mode-hook 'hs-minor-mode-keys)
(add-hook 'js2-mode-hook 'js-mode-keys)
(add-hook 'jsx-mode-hook 'js-mode-keys)

(defun hs-minor-mode-keys ()
  "hide-show code blocks minor mode"
  (local-set-key (kbd "M-=") 'hs-show-block)
  (local-set-key (kbd "M-+") 'hs-show-all)
  (local-set-key (kbd "M--") 'hs-hide-block)
  (local-set-key (kbd "M-_") 'hs-hide-all)
  (local-set-key (kbd "M-[") 'hs-hide-level))

(js2r-add-keybindings-with-prefix "<f6>")

(defun js-mode-keys ()
  "my keybindings for js2-mode"
  (local-set-key (kbd "C-c C-b") 'js-beautify)
  (local-set-key (kbd "M-.") 'etags-select-find-tag-at-point)
  (local-set-key (kbd "M-?") 'etags-select-find-tag))

;; projectile
(global-set-key (kbd "M-O") 'projectile-find-file)
(global-set-key (kbd "M-F") 'projectile-grep)

(global-set-key (kbd "C-z") 'zoom-window-zoom)

(global-set-key (kbd "<f5>") 'revert-buffer)

;; key sequence
(progn
  ;; define a prefix keymap
  (define-prefix-command 'vc-modes-key-map)
  (define-key vc-modes-key-map (kbd "g") 'magit-status)
  (define-key vc-modes-key-map (kbd "m") 'monky-status)
  (define-key vc-modes-key-map (kbd "a") 'vc-annotate)
  )

;; <f9> is a leader key
(global-set-key (kbd "<f9>") vc-modes-key-map)

;; key sequence
(progn
  ;; define a prefix keymap
  (define-prefix-command 'eshell-cmd-key-map)
  (define-key eshell-cmd-key-map (kbd "r") 'run-test)
  (define-key eshell-cmd-key-map (kbd "v") 'run-vpn)
  (define-key eshell-cmd-key-map (kbd "t") 'run-vnc)
  )

;; <f8> is a leader key
(global-set-key (kbd "<f8>") eshell-cmd-key-map)


(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "M-z") 'undo)
(global-set-key (kbd "C-z") 'undo)


;; comint
(defun comint-shell-modes-hook ()
   ;; rebind displaced commands that i still want a key
   (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
   (define-key comint-mode-map (kbd "<down>"и) 'comint-next-input)
)

(add-hook 'comint-mode-hook 'comint-shell-modes-hook)

(global-set-key (kbd "C-,") 'toggle-kbd-macro-recording-on)
(global-set-key (kbd "C-.") 'call-last-kbd-macro)
(global-set-key (kbd "C-k") 'kill-whole-line)

(global-set-key (kbd "C-l") 'goto-line)

(global-set-key (kbd "<home>") 'beginning-of-buffer)
(global-set-key (kbd "<end>") 'end-of-buffer)

(global-set-key (kbd "M-J") 'beginning-of-line)
(global-set-key (kbd "M-L") 'end-of-line)

(global-set-key (kbd "<M-S-right>") 'buf-move-right)
(global-set-key (kbd "<M-S-left>") 'buf-move-left)
(global-set-key (kbd "<M-S-up>") 'buf-move-up)
(global-set-key (kbd "<M-S-down>") 'buf-move-down)

(global-set-key (kbd "M-u") 'backward-word)
(global-set-key (kbd "M-o") 'forward-word)
(global-set-key (kbd "M-j") 'backward-char)
(global-set-key (kbd "M-l") 'forward-char)
(global-set-key (kbd "M-i") 'previous-line)
(global-set-key (kbd "M-k") 'next-line)

(global-set-key (kbd "M-K") 'scroll-up-command)
(global-set-key (kbd "M-I") 'scroll-down-command)

(global-set-key (kbd "M-R") 'rename-buffer)
;; cua-mode
;; (global-set-key (kbd "C-c r") 'cua-copy-region)

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      '(("i" "Inbox" entry (file+headline "~/Documents/personal-notes/inbox.org" "Tasks"))))

;; org-mode
(global-set-key (kbd "C-c M-p") (lambda() (interactive) (find-file "~/Documents/pomodoro.org")))

(add-hook 'org-mode-hook 'org-mode-keys)

(defun org-mode-keys ()
  "my keybindings for org-mode"
  (local-set-key (kbd "<M-S-up>") 'org-move-subtree-up)
  (local-set-key (kbd "<M-S-down>") 'org-move-subtree-down)
  (local-set-key (kbd "C-n") 'next-error)
  (local-set-key (kbd "<M-left>") 'org-metaleft)
  (local-set-key (kbd "<M-right>") 'org-metaright))

;;            (define-key org-mode-map (kbd "M-J") 'org-promote-subtree)
;;            (define-key org-mode-map (kbd "M-L") 'org-demote-subtree)))

(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
;; todo change keybindings here
(global-set-key (kbd "C-k") 'kill-whole-line)
(setq org-log-done t)
                                
;; mapping to caps/control as C and cmd as alt(meta)
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'control)
  (setq mac-command-modifier 'meta))
