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
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(use-package use-package)

(use-package
  ido-completing-read+ :ensure t)

(use-package
  typescript-mode :ensure t)

(use-package lsp-mode
  :ensure t
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (typescript-mode . lsp)
         (js-mode . lsp)
         (php-mode . lsp)
         ;(python-mode . lsp)
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

;(use-package lsp-python-ms
;  :ensure t
;  :hook (python-mode . (lambda ()
;                         (require 'lsp-python-ms)
;                         (lsp t)))
;  :init
;  (setq python-shell-exec-path "/usr/bin/python3.8")
;  (setq lsp-python-ms-executable (executable-find "python-language-server")))

(use-package exec-path-from-shell
  :ensure t)

;(use-package pipenv
;  :ensure t
;  :hook (python-mode . pipenv-mode)
;  :init
;  (setq
;   pipenv-projectile-after-switch-function
;   #'pipenv-projectile-after-switch-extended))

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp)))
  :init
  (setq python-shell-exec-path "/usr/bin/python3.8"))  ; or lsp-deferred

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
(use-package ytdl
  :ensure t
  :init
  (setq ytdl-music-folder (expand-file-name "~/Music")))
(use-package dashboard :ensure t)
(use-package ctrlf :ensure t)
(use-package prodigy :ensure t)
(use-package buffer-move :ensure t)
                                        ;(use-package dired-details :ensure t)
(use-package helm-swoop :ensure t)
(use-package flx-ido
  :ensure t
  :init
  (flx-ido-mode 1))

(use-package elm-mode :ensure t)
(use-package purescript-mode :ensure t)
(use-package haskell-mode
  :ensure t
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (haskell-mode . interactive-haskell-mode)))
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
(use-package gherkin-mode :ensure t)
                                        ;multi-eshell
                                        ;vue-mode
(use-package diff-hl :ensure t)
(use-package ws-butler :ensure t)
(use-package expand-region :ensure t)
(use-package flow-js2-mode :ensure t)

(use-package js2-mode
  :ensure t
  :hook (
         (js2-mode . flow-js2-mode)
         ))

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
(use-package yasnippet
  :ensure t
  :hook ((prog-mode . yas-minor-mode))
  :config
  (add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippets")
  (yas-reload-all))

(use-package yasnippet-snippets
  :ensure t
  :after (yasnippet))

(use-package php-mode :ensure t)
(use-package magit
  :ensure t
  :hook ((magit-mode . magit-todos-mode))
  :init
  (setq magit-completing-read-function 'magit-ido-completing-read))

(use-package magit-todos
  :ensure t
  :after (magit))

  ;;:hook ((magit-status-mode . helm-mode)))
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
                                        ;
                                        ;wanderlust
                                        ;htmlize
(use-package smartparens :ensure t)
(use-package terraform-mode :ensure t)
(use-package vuiet :ensure t)
(use-package plantuml-mode :ensure t)
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
(use-package cider :ensure t)
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

                                        ;(require 'json-reformat)
                                        ;(require 'lastfm)
                                        ;(require 'macros)
(require 'magit-tools)
                                        ;(require 'move-text)
                                        ;(require 'multi-eshell)
                                        ;(require 'orginit)
;;(require 'ox-confluence)
(require 'prog-mode-hooks)
(require 'projectile-setup)
                                        ;(require 'puml)
(require 'swissknife)
(require 'transpose-frame)
(require 'editor)

                                        ;(require 'web-dev)
                                        ;(require 'wrap-region)
                                        ;(require 'bind-key)
(require 'keymap)
(require 'js-beautify)
(setq lsp-log-io t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("4ed20d30a768c1a9032cf63aa8980723c21589c68838cd972f79e7ca2a414b9d" "7ea491e912d419e6d4be9a339876293fff5c8d13f6e84e9f75388063b5f794d6" default))
 '(package-selected-packages
   '(flow-js2-mode js2-mode gherkin-mode puml magit-todos ido-completing-read+ helm-flx yasnippet-snippets yasnippet flx-ido ytdl purescript-mode php-mode lsp-python-ms company company-mode company-capf modus-operandi-theme dap-firefox use-package))
 '(plantuml-default-exec-mode 'jar)
 '(plantuml-jar-path "/home/mico/scripts/puml/plantuml.jar")
 '(projectile-globally-ignored-directories
   '(".idea" ".vscode" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" ".ccls-cache" ".clangd" "ts_build" "node_modules")))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'ui-setup)
