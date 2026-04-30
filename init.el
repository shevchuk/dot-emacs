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
 '(browse-url-browser-function 'eww-browse-url)
 '(cider-boot-parameters "dev")
 '(custom-enabled-themes '(ef-spring))
 '(custom-safe-themes
   '("f0ddff48ec78dec9ac9ea3236e7208ef58a86d445207a674523c0eba8e9743b0"
     "02c9a1ffd2580abac661750036e79d598176458c7af6dc46ebf0aec422052d03"
     "ac893acecb0f1cf2b6ccea5c70ea97516c13c2b80c07f3292c21d6eb0cb45239"
     "a7472fb4143839f5bcd9dfdf722933d77b006a2b278f8863a7da2b88ad60b093"
     "ef518e42a90c237c49fe56de3c0e2706af35556d36e93f723aaf7fc3d85e196b"
     "b3ba955a30f22fe444831d7bc89f6466b23db8ce87530076d1f1c30505a4c23b"
     "3d9938bbef24ecee9f2632cb25339bf2312d062b398f0dfb99b918f8f11e11b1"
     "2551f2b4bc12993e9b8560144fb072b785d4cddbef2b6ec880c602839227b8c7"
     "a1c18db2838b593fba371cb2623abd8f7644a7811ac53c6530eebdf8b9a25a8d"
     "f544e09cb6c2a1047a751bcf5623ad70eb45981847b1c673263ce7de4858ae6b"
     "46dd3b30f3bb26b198eae5cc3d1e4dd79bc0e62af8f3431ae1785ddc4be47d44"
     "2b8dff32b9018d88e24044eb60d8f3829bd6bbeab754e70799b78593af1c3aba"
     "8f0a91a1df558a0f6891b9d31bb012ffd2c620caa1a409656a77b96e0ec886a9"
     "f95e22498a1a22af94542c796f0c330312181cacdcd403ab32e9fe074051c5da"
     "83e4bedd68c4696410af190367e47b4fcce6ae17be41dcef31beca674e32e7f9"
     "740813d6cad6d6e5ce610a4b67be4a575a3d22af9fc2e494b6f4c324c9e5a7e2"
     "f6cf3753918736a982bd5741ef9cd29aa70a09a07830a37796ed3ab7f5da2c5b"
     "0bc49a65bbc66fde922d08bd73b3068e7763cc98bf83a74dcbf0c66416e720fc"
     "10077e988cef1b336665e225ae8f7285c0134b90baa6369ee171274f99aa1dd6"
     "619beec7b0b2986c3b3517a8ae632167022388b9b397ec5f65af3388304239d4"
     "6b234feec8db588ad5ec2a9d9d7b935f7a155104b25ccfb94d921c45a2ff7d22"
     "180821795742c64e155841e8f9351b9d818e865d79dfc72f1aeab16b8724c9e4"
     "d8bcb88ef0a3259a38d6deba78e569c0750ebfede82ad3e6da16573419fef48c"
     "2d42de16fa73afacd149338fc6f7a7b3e9fc9b934678ff209f649ea0f24086aa"
     "d425e2488aee5a2f71abc4a49b1854423dd62575a3529f28aed55eb32190992c"
     "cd322dc37af17c4e122c99c93fe1a423dd1407797fe51d2278fc25c60a46be45"
     "9b88b8c64dc30188514f19d1be732ee71cc905b04b0c2c7eb1194528fcebbea4"
     "d6b05f096d6504aaa0018481dae6fcc9edad1c0658b3f584ea4958edc91714cf"
     "28cf1f7cc54ab4ee1ba4a4644046bd661941be92ef8327af56909f340cb9d3d5"
     "7de0917b4064219c0580397495d47b89a5f93d76724504d0ea8d2eea83542167"
     "e6cdd07a8475458edf8dfd8b5cb3d81c6bb9aa0cb8535322c21d2e242dd044ed"
     "8672c645e375c0f89575992c230f3f5ab5854b433c238ed871b59a88c8f1c602"
     "0141fea4ffa9c1fa02834b8681bdddac1b5e7e2bfce6b3c77c5cf0fc604ee8e3"
     "390af3f30c5d5b76739983cf8b85c8bbd04a46ac1488b11d150dec565ba82f55"
     "f8abe1fe632952b0fd198907f817accef48bd313fc6ec7ba2470953fcb483a87"
     "ea066684e9ace1e618719fab683b24a0fbcd3de82692190b1fe54e6b1b2a29bc"
     "8c01cb4cf9ee298d30a0456b1e90c575d8f5a047e35a5380a5f955c59ed17d2f"
     "231d11c79b7fb804ef2644580e15a544158d97854af407becfe4f4f78c3de402"
     "081d5c0ac32e611611bb90fbeaffc7f8d21fe5694180b68cc5243d554d1c3941"
     "5912c255e7e46432d6c1c057a2124cce807ad4b901a99bc43e838db0754dff91"
     "d2a14f85e1ba5b28433b96e4628444a4c6a2334368ddc2d568b06eb631492681"
     "338a3f155def6b84c2126d6ba8c453b2e5eea37b2195dd0465725849ceeeddfe"
     "8e57da9e594e7eb3a67952a58098e300b2a3be8c7b24bdf5f5b770f0746f7fb5"
     "a8021746a98a8147069ce4f31e14368c4e7dcf334fe1adff1408b4590d15fb4d"
     "0e55884b39a023ac216d125b20457d941288de3fcb1358938c37a93b2c394d4d"
     "8a19e3650988e71cf24b574ee1349c29a1528ed4be506cedc6f15a1ecc9d2355"
     "88c9a837824eab58891c94728fe0f45623d71eb618dcd0a7183166f17253b1b1"
     "8cc5fbb8e8dcf9d30f565b87fbe94f5d5c460ddebbf0bdc15e23ad5222ea2578"
     "27b3336b6115451a340275d842de6e8b1c49ce0bba45210ed640902240f8961d"
     "2b474647799a29add7e3cf34cd9f8178e872f6a4f354f58f4e717d93a53a4eed"
     "47f3e55e4e3d570d5513d4cc58047dc059bd6ab3d135c796c4ccbfb77d4eb88b"
     "ba9c91bc43996f2fa710e4b5145d9de231150103e142acdcf24adcaaf0db7a17"
     "0edb121fdd0d3b18d527f64d3e2b57725acb152187eea9826d921736bd6e409e"
     "feb8e98a8a99d78c837ce35e976ebcc97abbd8806507e8970d934bb7694aa6b3"
     "d6da24347c813d1635a217d396cf1e3be26484fd4d05be153f3bd2b293d2a0b5"
     "4ed20d30a768c1a9032cf63aa8980723c21589c68838cd972f79e7ca2a414b9d"
     "7ea491e912d419e6d4be9a339876293fff5c8d13f6e84e9f75388063b5f794d6"
     default))
 '(dashboard-image-banner-max-width 200)
 '(dashboard-startup-banner "~/.emacs.d/img/xemacs_color.svg")
 '(fancy-splash-image "~/.emacs.d/img/xemacs_color.svg")
 '(ignored-local-variable-values
   '((cider-jack-in-params "dev") (cider-preferred-build-tool . "boot")))
 '(linum-relative-current-symbol "")
 '(magit-todos-insert-after '(bottom) nil nil "Changed by setter of obsolete option `magit-todos-insert-at'")
 '(mastodon-active-user "mico")
 '(mastodon-instance-url "https://emacs.ch")
 '(nrepl-sync-request-timeout 100)
 '(package-selected-packages
   '(ellama quelpa pg dashboard-hackernews paredit sqlite3 clj-refactor
            linum-relative embark org-modern standard-themes emojify
            mastodon ef-themes excorporate telega cyberpunk-theme
            clojure-lsp lsp-clojure undo-tree diredfl org-present
            diff-hl-mode twig-mode rainbow-delimeters diredp dired+
            dired-plus restclient flow-js2-mode js2-mode gherkin-mode
            puml magit-todos ido-completing-read+ helm-flx
            yasnippet-snippets yasnippet flx-ido ytdl purescript-mode
            php-mode lsp-python-ms company company-mode company-capf
            modus-operandi-theme solo-jazz-theme dap-firefox
            use-package))
 '(plantuml-default-exec-mode 'jar)
 '(plantuml-jar-path "/home/mico/scripts/puml/plantuml.jar")
 '(projectile-globally-ignored-directories
   '(".idea" ".vscode" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout"
     "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work"
     ".ccls-cache" ".clangd" "ts_build" "*node_modules" "vendor"
     "storybook-static" "./var/cache" "*build/static/js"
     "./backend/vendor" "./service/build" "./service/coverage"
     ".clj-kondo" "./webapp/out" "./webapp/target"))
 '(projectile-globally-ignored-file-suffixes '(".map" ".log"))
 '(safe-local-variable-directories '("/home/mico/carify/"))
 '(safe-local-variable-values
   '((cider-clojure-cli-global-options . "-A:dev:test")
     (cider-ns-refresh-after-fn . "integrant.repl/resume")
     (cider-ns-refresh-before-fn . "integrant.repl/suspend")
     (eval progn
           (make-variable-buffer-local
            'cider-jack-in-nrepl-middlewares)
           (add-to-list 'cider-jack-in-nrepl-middlewares
                        "shadow.cljs.devtools.server.nrepl/middleware"))))
 '(undo-tree-auto-save-history t))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'ui-setup)
(put 'dired-find-alternate-file 'disabled nil)
