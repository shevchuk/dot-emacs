(add-to-list 'load-path "~/.emacs.d")
;;; first run will install these

;; these packages will be automatically installed if there is an internet connection
(defvar packages-to-load
  '(
    dsvn
    expand-region
    js2-mode
    magit
    ergoemacs-keybindings
    tern
))

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
