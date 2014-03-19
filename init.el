;; (set-background-color "lightblue")
(add-to-list 'load-path "~/.emacs.d")
;;; first run will install these

;; these packages will be automatically installed if there is an internet connection
(defvar packages-to-load
  '(
    twittering-mode
    jade-mode
    auto-complete
    dsvn
    expand-region
    js2-mode
    yasnippet
    js2-refactor
    coffee-mode
    ediff-trees
    magit
    ergoemacs-keybindings
    tern
    grizzl
    flx
    smex
    org-jira
    projectile
    wrap-region
    helm
    js-beautify
    rainbow-mode
    ;;    uniquify
))

;; javascript
(add-hook 'js2-mode-hook 
	  (lambda ()
        (define-key js2-mode-map (kbd "RET") 'newline-and-indent)
        (wrap-region-mode t)
	(linum-mode 1)
	    (tern-mode t)
        ;; Activate the folding mode
        (hs-minor-mode t)
	    (auto-complete-mode 1)))

(eval-after-load 'tern
   '(progn
      (require 'tern-auto-complete)
      (tern-ac-setup)))

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;;(add-to-list 'auto-mode-alist '("\\.erl\\'" . js2-mode))

(setq projectile-switch-project-action 'projectile-dired)
(setq projectile-enable-caching t)

(defadvice projectile-on (around exlude-tramp activate)
    (unless  (--any? (and it (file-remote-p it))
        (list
            (buffer-file-name)
            list-buffers-directory
            default-directory))
    ad-do-it))

(scroll-lock-mode t)


;; install packages if they are not installed yet
(require 'elget-loader)
(install-and-load packages-to-load)

(require 'fullscreen-toggle)
(require 'tramp)
(setq tramp-default-method "ssh")
(setq password-cache-expiry nil)
(setq tramp-verbose 6)

;;(setq projectile-indexing-method 'native)
(projectile-global-mode)

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

(require 'js-beautify)

;; erlang
(defun start-erlang ()
  (interactive)
  (setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.6.11/emacs/" load-path))
  (setq erlang-root-dir "/usr/local/lib/erlang")
  (setq exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
  (require 'erlang-start)
  (require 'erlang-flymake))

;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq tab-always-indent 'complete)
(setq indent-line-function 'insert-tab)

(put 'upcase-region 'disabled nil)

(require 'wrap-region)
(wrap-region-add-wrapper "/* " " */" "#" '(javascript-mode css-mode js2-mode))
(global-set-key (kbd "M-a") 'smex)

(setq-default cycle-bg-colors '("#27408b" "#00587b" "#004b15"))
(require 'cycle-bg-colors)
(require 'move-text)
(require 'swissknife)

;; theme setup
(load-theme 'misterioso t)

(when (string-equal system-type "darwin")
  (setenv "PATH" 
          (concat 
           "/usr/local/bin" ":"
           (getenv "PATH"))))

(require 'keymap)

(setq vc-svn-diff-switches "-x --ignore-eol-style")
;;exec-path
