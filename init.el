(add-to-list 'load-path "~/.emacs.d")
;;; first run will install these

;; these packages will be automatically installed if there is an internet connection
(defvar packages-to-load
  '(
    auto-complete
    dsvn
    expand-region
    js2-mode
    magit
    ergoemacs-keybindings
    tern
    projectile
))

;; javascript
(add-hook 'js2-mode-hook 
	  (lambda () 
	    (tern-mode t)
	    (projectile-mode t)
	    (auto-complete-mode 1)))

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

;; install packages if they are not installed yet
(require 'elget-loader)
(install-and-load packages-to-load)

(require 'fullscreen-toggle)

(require 'ido)
(ido-mode t)

;; ergo-emacs

;;to get rid of the log-edit-mode error, delete the line
;;(eval-when-compile (log-edit-mode))
;;in the file ergoemacs-keybindings/ergoemacs-mode.el
(package-initialize)
(setq ergoemacs-theme "lvl2")
(ergoemacs-mode 1)

;; Move to beginning/ending of line
(defconst ergoemacs-move-beginning-of-line-key	(kbd "M-H"))
(defconst ergoemacs-move-end-of-line-key	(kbd "M-L"))

(define-key ergoemacs-keymap ergoemacs-move-end-of-line-key 'move-end-of-line)
(define-key ergoemacs-keymap ergoemacs-move-beginning-of-line-key 'move-beginning-of-line)

;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

;; keymap
(when (eq system-type 'darwin) ;; mac specific settings
  (setq mac-option-modifier 'control)
  (setq mac-command-modifier 'meta))

;; editor
(define-key isearch-mode-map "\C-f" 'isearch-repeat-forward)
(global-set-key (kbd "M-0") 'er/expand-region)

(put 'upcase-region 'disabled nil)
