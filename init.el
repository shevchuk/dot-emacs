;; (set-background-color "lightblue")
(add-to-list 'load-path "~/.emacs.d")
;;; first run will install these

;; these packages will be automatically installed if there is an internet connection
(defvar packages-to-load
  '(auto-complete
    unicode-fonts
    dsvn
    expand-region
    js2-mode
    json-mode
    log4e
    yaxception
    tss
    yasnippet
    js2-refactor
    coffee-mode
    magit
    ergoemacs-keybindings
    tern
    grizzl
    flx
    smex
    org-jira
    projectile
    ;;wrap-region
    helm
    js-beautify
    rainbow-mode
    skewer-mode
    perspective
    exec-path-from-shell
    nodejs-repl
    ztree
    ;;    uniquify
    ;;jade-mode
))

(defun run-skewer-repl ()
  (interactive)
  (httpd-stop)
  (httpd-start)
  (skewer-repl))

;; coffee-mode
(defun coffee-custom ()
  "coffee-mode-hook"
  (linum-mode t))

(add-hook 'coffee-mode-hook '(lambda () (coffee-custom)))

(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

;; javascript
(add-hook 'js2-mode-hook 
          (lambda ()
            (yas-minor-mode)
            (define-key js2-mode-map (kbd "RET") 'newline-and-indent)
            (define-key js2-mode-map (kbd "C-r") 'run-skewer-repl)
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

;;yasnippets
(setq yas-snippet-dirs
      '("~/.emacs.d/yasnippets"))

(require 'yasnippet)
(yas/reload-all)

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

;; org
(setq org-agenda-files (list "~/Documents/personal-notes/work.org"
                             "~/Documents/personal-notes/nodify.org"
                             "~/Documents/personal-notes/personal.org"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t))) ; this line activates ditaa

(setq org-startup-with-inline-images t)
(add-hook 'org-mode-hook 
          (lambda () 
            (require 'unicode-fonts)
            (unicode-fonts-setup)
            (add-hook 'after-save-hook 'autocommit-after-save-hook nil 'make-it-local)))


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

(setq-default cycle-bg-colors '("#111122" "#112211" "#221122" "#112222" "#00587b" "#004b15"))
(require 'cycle-bg-colors)
(require 'move-text)
(require 'swissknife)
(require 'autocommit)

;; (require 'persp-projectile)
(require 'tern)
;; yasnippet

;; theme setup

(setq-default frame-title-format "%b (%f)")
(load-theme 'misterioso t)

(when (string-equal system-type "darwin")
  (setenv "PATH" 
          (concat 
           "/usr/local/bin" ":"
           (getenv "PATH"))))

(require 'keymap)
(setq vc-svn-diff-switches "-x --ignore-eol-style")
;;exec-path
(put 'downcase-region 'disabled nil)

(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(require 'json-reformat)

(when (memq window-system '(mac ns))
  (exec-path-from-shell-initialize))

(require 'transpose-frame)

;; If use bundled typescript.el,
(require 'typescript)
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

(require 'tss)

;; Key binding
(setq tss-popup-help-key "C-:")
(setq tss-jump-to-definition-key "C->")

;; Make config suit for you. About the config item, eval the following sexp.
;; (customize-group "tss")

;; Do setting recommemded configuration
(tss-config-default)

(tool-bar-mode -1)
