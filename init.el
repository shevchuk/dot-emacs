;; Allow 20MB of memory (instead of 0.76MB) before calling garbage collection. This means GC runs less often, which speeds up some operations.
(setq gc-cons-threshold 100000000)
(setq ring-bell-function 'ignore)
(require 'server)
(or (server-running-p)
    (server-start))

;; Require and initialize `package`.
(require 'package)
(package-initialize)

(setq create-lockfiles nil)
(setq package-archives '(("melpa" . "http://melpa.org/packages/")
                         ("org" . "http://orgmode.org/elpa/")
                         ("gnu" . "http://elpa.gnu.org/packages/")))

;; Remove this model
;(when (not (package-installed-p 'use-package))
;  (package-refresh-contents)
;  (package-install 'use-package))

;(use-package use-package)

(use-package
  ido-completing-read+ :ensure t)

(use-package
  typescript-mode :ensure t)

(use-package
  colorful-mode :ensure t
  :custom
  (colorful-use-prefix t)
  (colorful-only-strings 'only-prog)
  (css-fontify-colors nil)
  :config
  (global-colorful-mode t)
  (add-to-list 'global-colorful-modes 'helpful-mode))

(add-hook 'conf-mode-hook
          (lambda ()
            (colorful-mode 1)))  ;; Ensure colorful-mode is applied after conf-mode


(use-package
  twig-mode :ensure t)

;; straight bootstrap
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name
        "straight/repos/straight.el/bootstrap.el"
        (or (bound-and-true-p straight-base-dir)
            user-emacs-directory)))
      (bootstrap-version 7))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; clojure
;; yay -S clojure-lsp-bin


(use-package lsp-mode
  :init
  (add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))
  :ensure t
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (typescript-mode . lsp)
         (js-mode . lsp)
         (javascript-mode . lsp)
         (clojure-mode . lsp)
         (php-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . (lambda ()
                       ;; fix lsp-doctor warning
                       (setq read-process-output-max (* 1024 1024))
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

(use-package exec-path-from-shell
  :ensure t)

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                          (require 'lsp-pyright)
                          (lsp)))
  :init
  (setq python-shell-exec-path "/usr/bin/python3.8"))  ; or lsp-deferred

(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/number-convert"))
;(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/themes"))

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

(use-package
  restclient :ensure t)

(use-package dashboard :ensure t)
(use-package ctrlf :ensure t)
(use-package prodigy :ensure t)
(use-package buffer-move :ensure t)
                                        ;(use-package dired-details :ensure t)
(use-package diredfl
  :ensure t
  :hook ((dired-mode . diredfl-mode)))

(use-package undo-tree
  :ensure t
  :init
  (global-undo-tree-mode))

(use-package helm :ensure t)
;(use-package helm-occur :ensure t)
(use-package flx-ido
  :ensure t
  :init
  (flx-ido-mode 1))

(use-package elm-mode :ensure t)
(use-package purescript-mode :ensure t)
(use-package go-mode :ensure t)

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
(use-package yaml-mode :ensure t)
(use-package super-save :ensure t)
(use-package gherkin-mode :ensure t)
                                        ;multi-eshell
                                        ;vue-mode
(use-package diff-hl
  :ensure t
  :hook ((prog-mode . diff-hl-mode)))

(use-package ws-butler :ensure t)
(use-package expand-region :ensure t)
(use-package flow-js2-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("\\.flow$" . js2-mode)))

(use-package js2-mode
  :ensure t
  :hook (
         (js2-mode . flow-js2-mode)))

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

(use-package rainbow-delimiters
  :ensure t
  :hook ((prog-mode . rainbow-delimiters-mode)))

(use-package php-mode :ensure t)
(use-package magit
  :ensure t
  ; todos make magit slow
  ;:hook ((magit-mode . magit-todos-mode))
  ;:init
  ;(setq magit-completing-read-function #'helm-comp-read)
  )

(use-package magit-todos
  :ensure t
  :after (magit))

(use-package forge
  :ensure t
  :after magit
  :init
  (setq auth-sources '("~/.authinfo")))

(use-package whisper
  :vc (:url "https://github.com/natrys/whisper.el" :branch "master"))

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
(use-package bind-key)
(use-package org-present :ensure t)

;; fixes
(setq org-babel-js-function-wrapper
      "process.stdout.write(require('util').inspect(function(){\n%s\n}(), { maxArrayLength: null, maxStringLength: null, breakLength: Infinity, compact: true }))")

(org-babel-do-load-languages
      'org-babel-load-languages
      '((js . t)))

(use-package cider :ensure t)



(use-package paredit
  :ensure t
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (clojure-mode . paredit-mode)))

(require 'quelpa)

(quelpa
 '(quelpa-use-package
   :fetcher git
   :url "https://github.com/quelpa/quelpa-use-package.git"))

(require 'quelpa-use-package)

(use-package pgmacs
  :ensure nil
  :defer t
  :quelpa (pgmacs :fetcher github :repo "emarsden/pgmacs"))

;(use-package emidje :ensure t :after (cider) :init (emidje-setup))
                                        ;feature-mode
                                        ;lastfm
                                        ;vuiet
                                        ;jest-test-mode
                                        ;))

;(use-package pg :vc (:url "https://github.com/emarsden/pg-el"))

(use-package all-the-icons :ensure t)

;(use-package modus-operandi-theme :ensure t)
; see ui-setup.el that turns the theme on
;(use-package solo-jazz-theme :ensure t)

(use-package powerline :ensure t)
(use-package airline-themes :ensure t)

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
(require 'move-text)
                                        ;(require 'multi-eshell)
(require 'orginitnew)
;;(require 'ox-confluence)
(require 'prog-mode-hooks)
(require 'projectile-setup)
                                        ;(require 'puml)
(require 'swissknife)
(require 'number-convert)
(require 'placeholder)


(require 'transpose-frame)
(require 'editor)

(require 'paredit-keys)

(require 'ai)

(require 'my-keymap)
(require 'jet)
(require 'js-beautify)
(setq lsp-log-io t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("a7472fb4143839f5bcd9dfdf722933d77b006a2b278f8863a7da2b88ad60b093"
     default))
 '(package-vc-selected-packages
   '((whisper :url "https://github.com/natrys/whisper.el" :branch
              "master"))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'ui-setup)
(put 'dired-find-alternate-file 'disabled nil)
