(add-to-list 'load-path "~/.emacs.d")
;;; first run will install these

;; these packages will be automatically installed if there is an internet connection
(defvar packages-to-load
  '(
    auto-complete
    dsvn
    expand-region
    js2-mode
    yasnippet
    js2-refactor
    magit
    ergoemacs-keybindings
    tern
    grizzl
    flx
    projectile
    wrap-region
))

;; javascript
(add-hook 'js2-mode-hook 
	  (lambda () 
        (wrap-region-mode t)
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

;; ido
(ido-mode t)
(ido-everywhere 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)

;; ergo-emacs

;;to get rid of the log-edit-mode error, delete the line
;;(eval-when-compile (log-edit-mode))
;;in the file ergoemacs-keybindings/ergoemacs-mode.el
(package-initialize)
(setq ergoemacs-theme "lvl2")
(ergoemacs-mode 1)

(require 'keymap)

;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(put 'upcase-region 'disabled nil)

(require 'wrap-region)
(wrap-region-add-wrapper "/* " " */" "#" '(javascript-mode css-mode js2-mode))

