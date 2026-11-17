;; Move to beginning/ending of line

(defconst ergoemacs-move-beginning-of-line-key (kbd "M-H"))
(defconst ergoemacs-move-end-of-line-key (kbd "M-L"))

(defconst ergoemacs-isearch-forward-key (kbd "M-;"))
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
  (local-set-key (kbd "M-[") 'my-hs-hide-level)) ; tty-safe wrapper, see bottom of file

(defun js-mode-keys ()
  "my keybindings for js2-mode"
  (local-set-key (kbd "C-c C-b") 'js-beautify)
  (local-unset-key (kbd "M-j"))
  (local-set-key (kbd "<F9>") 'nodejs-repl-send-region)
  (local-set-key (kbd "C-q") 'nodejs-repl-send-region))

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

(global-set-key (kbd "<f6>") eshell-cmd-key-map)


(defalias 'redo 'undo-tree-redo)
(global-set-key (kbd "M-z") 'undo)
(global-set-key (kbd "C-z") 'undo)

;; comint
(defun comint-shell-modes-hook ()
   ;; rebind displaced commands that i still want a key
   (define-key comint-mode-map (kbd "<up>") 'comint-previous-input)
   (define-key comint-mode-map (kbd "<down>") 'comint-next-input)
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

(global-set-key (kbd "C-c C-n d") 'number-convert/hex-to-dec-at-point)
(global-set-key (kbd "C-c C-n h") 'number-convert/dec-to-hex-at-point)

;; todo change keybindings here
(setq org-log-done t)

(defun org-present-mode-keys ()
  (local-set-key (kbd "<right>") 'org-present-next)
  (local-set-key (kbd "<left>") 'org-present-prev))

(add-hook 'org-present-mode-hook 'org-present-mode-keys)

;; paredit keys
(eval-after-load 'paredit
'(progn
         (define-key paredit-mode-map (kbd "C-i") 'paredit-kill)
         (define-key paredit-mode-map (kbd "C-s") 'paredit-splice-sexp)

         (define-key paredit-mode-map (kbd "C->") 'paredit-splice-sexp-killing-backward)
         (define-key paredit-mode-map (kbd "C-<") 'paredit-splice-sexp-killing-forward)

         (define-key paredit-mode-map (kbd "C-c r") 'paredit-raise-sexp)
         (define-key paredit-mode-map (kbd "C-c s") 'paredit-split-sexp)
         (define-key paredit-mode-map (kbd "C-c j") 'paredit-join-sexps)

         ;(define-key paredit-mode-map (kbd "C-j") nil)
         ))

;; mapping to caps/control as C and cmd as alt(meta)
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'control)
  (setq mac-command-modifier 'meta))

(define-key lsp-mode-map (kbd "<f8>") lsp-command-map)

(bind-keys*
 ("M-x" . kill-region)
 ("M-d" . kill-word-at-point)
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
 ("M-2" . delete-window)
 ("M-8" . split-window-below)
 ("M-9" . split-window-right)
 ("M-s" . other-window)
 ("<C-tab>" . other-frame)
 ("C-x C-j" . dired-jump)
 ("C-b" . bookmark-set)
 ("M-b" . bookmark-jump)
 ("\C-r" . isearch-backward)
 ("<f7>" . helm-occur)
 ("M-0" . er/expand-region)
 ("<f4>" . ido-find-file)
 ("<f12>" . smex)
 ("M-O" . my-projectile-find-file) ; tty-safe wrapper, see bottom of file
 ("M-F" . projectile-grep)
 ("C-x b" . projectile-switch-to-buffer)
 ("C-z" . zoom-window-zoom)
 ("<f5>" . revert-buffer)
 ;("<f8>" . shell-cmd-key-map)
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
 ("<M-up>" . move-text-up)
 ("<M-down>" . move-text-down)
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
 ("M-." . xref-find-definitions)
 ("M-p" . ace-window))

;; Terminal escape-sequence guard for M-O and M-[.
;;
;; In a terminal, M-O is the byte pair "ESC O" and M-[ is "ESC [".  These are
;; also the prefixes of cursor keys ("ESC O A" = <up>), PgUp/Del/C-<arrow>
;; ("ESC [ 5 ~", "ESC [ 1 ; 5 A") and bracketed paste ("ESC [ 200 ~").
;; Emacs stops reading a key sequence as soon as it is bound to a command,
;; even if `input-decode-map' has a longer match, so binding M-O / M-[ makes
;; the arrows run that command instead.
;;
;; A terminal sends an escape sequence in one burst, while a human typing M-O
;; never follows it with another key within milliseconds.  So, on a tty,
;; these wrappers peek for immediately pending input: if it completes a known
;; key sequence the decoded key is replayed, otherwise the command runs.

(defvar my-tty-escape-timeout 0.02
  "Seconds to wait for the rest of a terminal escape sequence.")

(defun my-tty--read-escape-tail (intro)
  "Read the bytes after ESC INTRO that are already pending, as a list."
  (let (tail ev)
    (if (eq intro ?O)
        ;; SS3: exactly one final byte, e.g. ESC O A
        (when (setq ev (read-event nil nil my-tty-escape-timeout))
          (push ev tail))
      ;; CSI: parameter/intermediate bytes, then one final byte (0x40-0x7E)
      (while (and (< (length tail) 16)
                  (setq ev (read-event nil nil my-tty-escape-timeout))
                  (progn (push ev tail)
                         (and (integerp ev) (<= #x20 ev #x3f))))))
    (nreverse tail)))

(defun my-tty--translate (seq)
  "Return the key that terminal sequence SEQ decodes to, or nil."
  (let ((b (or (lookup-key input-decode-map seq)
               (lookup-key local-function-key-map seq))))
    (cond ((and (arrayp b) (not (keymapp b))) b)
          ((and (functionp b) (not (keymapp b))) (funcall b nil)))))

(defun my-tty-escape-guard (intro command)
  "Run COMMAND, unless on a tty ESC INTRO starts a terminal key sequence."
  (let ((tail (and (not (display-graphic-p))
                   (my-tty--read-escape-tail intro))))
    (if (null tail)
        (call-interactively command)
      (let ((key (and (seq-every-p #'integerp tail)
                      (my-tty--translate (vconcat (list ?\e intro) tail)))))
        (if key
            (setq unread-command-events
                  (append (listify-key-sequence key) unread-command-events))
          (setq unread-command-events (append tail unread-command-events))
          (call-interactively command))))))

(defun my-projectile-find-file ()
  "`projectile-find-file' that does not swallow tty cursor keys (ESC O ...)."
  (interactive)
  (my-tty-escape-guard ?O #'projectile-find-file))

(defun my-hs-hide-level ()
  "`hs-hide-level' that does not swallow tty key sequences (ESC [ ...)."
  (interactive)
  (my-tty-escape-guard ?\[ #'hs-hide-level))

(provide 'my-keymap)
