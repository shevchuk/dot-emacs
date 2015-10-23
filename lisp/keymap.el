;; Move to beginning/ending of line
(defconst ergoemacs-move-beginning-of-line-key	(kbd "M-H"))
(defconst ergoemacs-move-end-of-line-key	(kbd "M-L"))
(defconst ergoemacs-delete-window (kbd "M-2"))
(defconst ergoemacs-delete-other-windows (kbd "M-1"))
(defconst ergoemacs-split-window-below (kbd "M-8"))
(defconst ergoemacs-split-window-right (kbd "M-9"))

(defconst ergoemacs-isearch-forward-key	(kbd "M-;"))
(defconst ergoemacs-isearch-backward-key (kbd "M-:"))

(define-key ergoemacs-keymap ergoemacs-move-end-of-line-key 'move-end-of-line)
(define-key ergoemacs-keymap ergoemacs-move-beginning-of-line-key 'move-beginning-of-line)
(define-key ergoemacs-keymap ergoemacs-split-window-below 'split-window-below)
(define-key ergoemacs-keymap ergoemacs-split-window-right 'split-window-right)
(define-key ergoemacs-keymap ergoemacs-delete-window 'delete-window)
(define-key ergoemacs-keymap ergoemacs-delete-other-windows 'delete-other-windows)


(global-set-key (kbd "<mouse-2>") 'split-window-vertically)
(global-set-key (kbd "<mouse-3>") 'split-window-horizontally)

;; editor
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(define-key isearch-mode-map "\C-r" 'isearch-yank-region)

(global-set-key (kbd "\C-r") 'isearch-backward)

(global-set-key (kbd "M-0") 'er/expand-region)
(global-set-key (kbd "<f4>") 'ido-kill-buffer)

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
  (local-set-key (kbd "C-b") 'js-beautify)
  (local-set-key (kbd "M-.") 'etags-select-find-tag-at-point)
  (local-set-key (kbd "M-?") 'etags-select-find-tag))

;; projectile
(global-set-key (kbd "M-O") 'projectile-find-file)
(global-set-key (kbd "M-F") 'projectile-grep)

(global-set-key (kbd "C-z") 'zoom-window-zoom)

(global-set-key (kbd "<f5>") 'revert-buffer)

;; comint
(defun comint-shell-modes-hook ()
   ;; rebind displaced commands that i still want a key
   (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
   (define-key comint-mode-map (kbd "<down>") 'comint-next-input)
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

;; cua-mode
;; (global-set-key (kbd "C-c r") 'cua-copy-region)

(global-set-key (kbd "C-c c") 'org-capture)

(setq org-capture-templates
      '(("w" "Work Todo" entry (file+headline "~/Documents/personal-notes/work.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("p" "Personal" entry (file+headline "~/Documents/personal-notes/personal.org" "Tasks")
         "* TODO %?\n %i\n")
      ("n" "Nodify Todo" entry (file "~/Documents/personal-notes/nodfiy.org")
       "* TODO %?\n  %i\n  %a")))


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

(global-set-key (kbd "M-<up>") 'move-text-up)
(global-set-key (kbd "M-<down>") 'move-text-down)

;; mapping to caps/control as C and cmd as alt(meta)
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'control)
  (setq mac-command-modifier 'meta))
