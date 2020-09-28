;; Allow 20MB of memory (instead of 0.76MB) before calling garbage collection. This means GC runs less often, which speeds up some operations.
(setq gc-cons-threshold 20000000)

(setq ring-bell-function 'ignore)
(require 'server)
(or (server-running-p)
    (server-start))

;; Require and initialize `package`.
(require 'package)
(package-initialize)

(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(use-package use-package)

(use-package
  typescript-mode :ensure t)

(use-package lsp-mode
  :ensure t
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (typescript-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . (lambda ()
                      (let ((lsp-keymap-prefix "<F8>"))
                        (lsp-enable-which-key-integration)))))
  :commands lsp)

;; optionally
(use-package lsp-ui :commands lsp-ui-mode :ensure t)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol :ensure t)

;; optionally if you want to use debugger
(use-package dap-mode :ensure t)
(use-package dap-firefox) ;to load the dap adapter for your language
(use-package company :ensure t)
(use-package lsp-python-ms
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-python-ms)
                         (lsp)))
  :init
  (setq lsp-python-ms-executable (executable-find "python-language-server")))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
;;; first run will install these

;; these packages will be automatically installed if there is an internet connection
;(defvar packages-to-load
(use-package which-key
  :ensure t
  :custom
  (which-key-popup-type 'side-window)
  (which-key-side-window-location 'bottom)
  (which-key-side-window-max-height 0.25)
  :bind
  ("C-h C-k" . which-key-show-top-level)
  :config
  (which-key-mode))
(use-package smex :ensure t)
(use-package dashboard :ensure t)
(use-package ctrlf :ensure t)
(use-package prodigy :ensure t)
(use-package buffer-move :ensure t)
;(use-package dired-details :ensure t)
(use-package helm-swoop :ensure t)
	
    ;color-theme
    ;zoom-window
    ;ido-vertical-mode
    ;flx-ido
    ;yaml-mode
    ;company-go
    ;mmm-mode
    ;multi-compile
    ;go-eldoc
    ;gherkin-mode
 (use-package emmet-mode :ensure t)
 (use-package super-save :ensure t)
    ;multi-eshell
    ;vue-mode
 (use-package diff-hl :ensure t)
 (use-package ws-butler :ensure t)
 (use-package expand-region :ensure t)
    ;js2-mode
    ;flow-js2-mode
    ;button-lock
    ;json-mode
    ;typescript-mode
    ;rjsx-mode
    ;jira-markup-mode
    ;nvm
    ;log4e
    ;go-mode
    ;ace-window
    ;yasnippet
    ;js2-refactor
    ;web-mode
    ;php-mode
 (use-package magit :ensure t)
 (use-package auto-highlight-symbol :ensure t)
    ;add-node-modules-path ; needed for vue mode hooks
 (use-package highlight-parentheses :ensure t)
    ;grizzl
    ;smex
    ;unbound
 (use-package projectile :ensure t)
 ;(use-package dired+ :ensure t)
    ;;wrap-region
    ;easy-kill
    ;js-beautify
    ;perspective
    ;exec-path-from-shell
    ;nodejs-repl
    ;;org-reveal
    ;org-plus-contrib
    ;wanderlust
    ;htmlize
 (use-package smartparens :ensure t)
 (use-package terraform-mode :ensure t)
    ;fancy-narrow
    ;s
    ;ag
    ;dash
    ;google-translate-f279801
    ;plantuml-mode
 (use-package flycheck-plantuml :ensure t)
    ;powerline
    ;swap-regions
    ;bind-key
    ;cider
    ;feature-mode
    ;lastfm
    ;vuiet
    ;jest-test-mode
;))

(use-package all-the-icons :ensure t)

(use-package modus-operandi-theme :ensure t)
(use-package powerline :ensure t)
(use-package airline-themes :ensure t)
;; install packages if they are not installed yet
;(require 'elget-loader)
;(install-and-load packages-to-load)
;(package-initialize)

;(require 'autocommit)
;(require 'buffer-move)
;(require 'copy-as-format)
(require 'env-setup)
;(require 'eshell-misc)
;(require 'etags-select)
;(require 'ido-setup)
;(require 'issue-link)
;(require 'js-beautify)
;(require 'json-reformat)
;(require 'lastfm)
;(require 'macros)
(require 'magit-tools)
;(require 'move-text)
;(require 'multi-eshell)
;(require 'orginit)
;(require 'ox-confluence)
(require 'prog-mode-hooks)
;(require 'projectile-setup)
;(require 'puml)
(require 'swissknife)
(require 'transpose-frame)
(require 'ui-setup)
(require 'editor)

;(require 'vuiet)
;(require 'web-dev)
;(require 'wrap-region)
(require 'ws-butler)
;(require 'erlang-dev)
;(require 'golang)
;(require 'tscript)
;(require 'bind-key)
(require 'keymap)

(setq lsp-log-io t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (lsp-python-ms company company-mode company-capf modus-operandi-theme dap-firefox use-package)))
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".vscode" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" ".ccls-cache" ".clangd" "ts_build" "node_modules"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
