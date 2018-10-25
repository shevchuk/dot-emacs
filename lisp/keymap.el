;; Move to beginning/ending of line

(defconst ergoemacs-move-beginning-of-line-key	(kbd "M-H"))
(defconst ergoemacs-move-end-of-line-key	(kbd "M-L"))

(defconst ergoemacs-isearch-forward-key	(kbd "M-;"))
(defconst ergoemacs-isearch-backward-key (kbd "M-:"))

(defun copy-line (arg)
      "Copy lines (as many as prefix argument) in the kill ring"
      (interactive "p")
      (kill-ring-save (line-beginning-position)
                      (line-beginning-position (+ 1 arg)))
      (message "%d line%s copied" arg (if (= 1 arg) "" "s")))

(define-key minibuffer-local-map (kbd "M-r") 'kill-word) ; was previous-matching-history-element.
(define-key minibuffer-local-map (kbd "M-s") 'other-window) ; was nest-matching-history-element

;; editor
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(define-key isearch-mode-map "\C-r" 'isearch-yank-region)

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

(defun js-mode-keys ()
  "my keybindings for js2-mode"
  (local-set-key (kbd "C-c C-b") 'js-beautify)
  (local-set-key (kbd "s-SPC") 'company-tern)
  (local-unset-key (kbd "M-j"))
  (local-set-key (kbd "C-c C-c") 'nodejs-repl-send-region)
  (local-set-key (kbd "M-.") 'etags-select-find-tag-at-point)
  (local-set-key (kbd "M-?") 'etags-select-find-tag))

;; projectile
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

;; <f8> key sequence 
(progn
  ;; define a prefix keymap
  (define-prefix-command 'eshell-cmd-key-map)
  (define-key eshell-cmd-key-map (kbd "r") 'run-test)
  (define-key eshell-cmd-key-map (kbd "v") 'run-vpn)
  (define-key eshell-cmd-key-map (kbd "t") 'run-vnc)
  )

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

;; macro
(setq org-capture-templates
      '(("i" "Inbox" entry (file+headline "~/Documents/personal-notes/inbox.org" "Tasks"))))


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

(global-set-key "\C-ct" 'google-translate-smooth-translate)
(global-set-key "\C-cT" 'google-translate-query-translate)

;; todo change keybindings here
(setq org-log-done t)
                                
;; mapping to caps/control as C and cmd as alt(meta)
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'control)
  (setq mac-command-modifier 'meta))

(bind-keys*
 ("M-x" . kill-region)
 ("M-v" . yank)
 ("<f2>" . save-buffer)
 ("M-c" . kill-ring-save)
 ("M-C" . copy-line)
 ("M-D" . duplicate-line)
 ("M-K" . kill-whole-line)
 ("M-e" . backward-kill-word)
 ("<mouse-2>" . x-clipboard-yank)
 ("C-f" . isearch-forward)
 ("M-3" . delete-other-windows)                                                
 ("M-8" . split-window-below)
 ("M-9" . split-window-right)
 ("M-s" . other-window)
 ("C-x C-j" . dired-jump)
 ("C-b" . bookmark-set)
 ("M-b" . bookmark-jump)
 ("\C-r" . isearch-backward)
 ("<f7>" . helm-swoop)
 ("M-0" . er/expand-region)
 ("<f4>" . ido-find-file)
 ("<f12>" . smex)
 ("M-O" . projectile-find-file)
 ("M-F" . ag-project)
 ("C-z" . zoom-window-zoom)
 ("<f5>" . revert-buffer)
 ("<f8>" . shell-cmd-key-map)
 ("C-," . toggle-kbd-macro-recording-on)
 ("C-." . call-last-kbd-macro)
 ("C-k" . kill-whole-line)
 ("C-l" . goto-line)
 ("<home>" . beginning-of-buffer)
 ("<end>" . end-of-buffer)
 ("M-J" . beginning-of-line)
 ("M-L" . end-of-line)
 ("<M-S-right>" . buf-move-right)
 ("<M-S-left>" . buf-move-left)
 ("<M-S-up>" . buf-move-up)
 ("<M-S-down>" . buf-move-down)
 ("M-u" . backward-word)
 ("M-o" . forward-word)
 ("M-j" . backward-char)
 ("M-l" . forward-char)
 ("s-d" . delete-window)
 ("s-o" . delete-other-windows)
 ("s-b" . split-window-below)
 ("s-r" . split-window-right)
 ("<escape> <escape>" . kill-this-buffer)
 ("M-i" . previous-line)
 ("M-k" . next-line)
 ("M-K" . scroll-up-command)
 ("M-I" . scroll-down-command)
 ("<XF86Calculator>" . calculator)
 ("M-R" . rename-buffer)
 ("C-c c" . org-capture)
 ("C-k" . kill-whole-line)
 ("M-a" . mark-whole-buffer)
 ("<f10>" . icicle-select-frame)
 ("M-p" . ace-window))

