;; Allow 20MB of memory (instead of 0.76MB) before calling garbage collection. This means GC runs less often, which speeds up some operations.
(setq gc-cons-threshold 20000000)

(setq ring-bell-function 'ignore)
(require 'server)
(or (server-running-p)
    (server-start))

;; (set-background-color "lightblue")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
;;; first run will install these

;; these packages will be automatically installed if there is an internet connection
(defvar packages-to-load
  '(
    paredit
    elfeed ;; rss feed
    auto-complete
    counsel-etags
    markdown-mode
    prodigy
    ht
    spinner
    buffer-move
    restclient
    dired-details
    helm-swoop
    color-theme
    diminish ;; hides modes from mode-line
    zoom-window
    sublime-themes
    ido-vertical-mode
    yaml-mode
    company-mode
    company-go
    mmm-mode
    flycheck
    multi-compile
    go-eldoc
    auto-complete
    gherkin-mode
    emmet-mode
    super-save
    multi-eshell
    vue-mode
    diff-hl
    ws-butler
    unicode-fonts
    dsvn
    expand-region
    js2-mode
    flow-js2-mode
    button-lock
    json-mode
    jsx-mode
    tss
    tide
    typescript-mode
    rjsx-mode
    jira-markup-mode
    nvm
    log4e
    yaxception
    go-mode
    ace-window
    yasnippet
    js2-refactor
    coffee-mode
    web-mode
    php-mode
    magit
    auto-highlight-symbol
    add-node-modules-path ; needed for vue mode hooks
    highlight-parentheses
    grizzl
    flx-ido
    smex
    unbound
    ;;helm-swoop
    projectile
    dired+
    ;;wrap-region
    ;;helm
    ;;helm-projectile
    easy-kill
    js-beautify
    skewer-mode
    perspective
    exec-path-from-shell
    nodejs-repl
    ;;org-reveal
    wanderlust
    ztree
    ;;undo-tree
    ;;    uniquify
    htmlize
    smartparens
    ;;drag-stuff
    ;; themes
    terraform-mode
    monokai-theme
    fancy-narrow
    s
    ag
    dash
    google-translate
    annoying-arrows-mode
    powerline
    spaceline
    yandex-weather
    airline-themes
    anti-zenburn-theme
    dracula-theme
    lab-themes
    moe-theme
    dracula-theme
    swap-regions
    bind-key
))

(add-hook 'terraform-mode-hook
    (lambda ()
        (lsp t)
        (lsp-register-client
            (make-lsp-client :new-connection (lsp-stdio-connection '("/home/mico/bin/tf-lsp/terraform-lsp" "-enable-log-file"))
                  :major-modes '(terraform-mode)
                  :server-id 'terraform-ls))))


(defun run-skewer-repl ()
  (interactive)
  (httpd-stop)
  (httpd-start)
  (skewer-repl))

(add-hook 'coffee-mode-hook '(lambda () (coffee-custom)))
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))

(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)
(add-hook 'sh-mode-hook 'flycheck-mode)

;; javascript
(add-hook 'js2-mode-hook 
          (lambda ()
            (define-key js2-mode-map (kbd "RET") 'newline-and-indent)
            (wrap-region-mode t)
            (js2-refactor-mode t)
            (flow-js2-mode t)
            (smartparens-mode t)
            ;; Activate the folding mode
            (hs-minor-mode t)
            (rjsx-minor-mode t)
            (lsp t)
            (smartparens-mode t)
            (flycheck-mode 1)
            ))

(add-hook 'php-mode-hook
          (lambda ()
            (lsp t)))

;; LSP :: You can configure this warning with the `lsp-enable-file-watchers' and `lsp-file-watch-threshold' variables
(setq lsp-enable-file-watchers t)
(setq lsp-file-watch-threshold 1000)


(define-minor-mode sticky-buffer-mode
  "Make the current window always display this buffer."
  nil " sticky" nil
  (set-window-dedicated-p (selected-window) sticky-buffer-mode))

(add-hook 'sticky-buffer-mode-hook
          (lambda ()
            ;;(face-remap-add-relative 'mode-line '((:foreground "blue4" :background "OliveDrab1") mode-line))
            ))

;; git shows branch + changes
(defadvice vc-git-mode-line-string (after plus-minus (file) compile activate)
  (setq ad-return-value
    (concat ad-return-value
            (let ((plus-minus (vc-git--run-command-string
                               file "diff" "--numstat" "--")))
              (and plus-minus
                   (string-match "^\\([0-9]+\\)\t\\([0-9]+\\)\t" plus-minus)
                   (format " +%s-%s" (match-string 1 plus-minus) (match-string 2 plus-minus)))))))

(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'after-init-hook 'global-diff-hl-mode)

(add-hook 'prog-mode-hook #'ws-butler-mode)
(add-hook 'prog-mode-hook #'whitespace-mode)
(add-hook 'prog-mode-hook #'linum-mode)
(add-hook 'prog-mode-hook #'auto-highlight-symbol-mode)
(add-hook 'prog-mode-hook #'highlight-parentheses-mode)
;; Emacs gets annoyed when you navigate around your document one char at a time.
(add-hook 'prog-mode-hook #'annoying-arrows-mode)
(add-hook 'prog-mode-hook #'column-number-mode)

(with-eval-after-load 'yasnippet
  (require 'yas))

(require 'dired-x)
(setq-default dired-omit-files-p nil) ; Buffer-local variable

(progn
 ;; Make whitespace-mode with very basic background coloring for whitespaces.
  ;; http://ergoemacs.org/emacs/whitespace-mode.html
  (setq whitespace-style (quote (face spaces tabs newline space-mark tab-mark newline-mark )))

  ;; Make whitespace-mode and whitespace-newline-mode use “¶” for end of line char and “▷” for tab.
  (setq whitespace-display-mappings
        ;; all numbers are unicode codepoint in decimal. e.g. (insert-char 182 1)
        '(
          (space-mark 32 [183] [46]) ; SPACE 32 「 」, 183 MIDDLE DOT 「·」, 46 FULL STOP 「.」
          (newline-mark 10 [8629 10]) ; LINE FEED,
          (tab-mark 9 [9655 9] [92 9]) ; tab
          )))


(add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.flow\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jira\\'" . jira-markup-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.erl\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
(add-to-list 'auto-mode-alist '("\\.feature\\'" . gherkin-mode))

(add-hook 'vue-mode-hook #'linum-mode)
(add-hook 'vue-mode-hook #'whitespace-mode)
(add-hook 'vue-mode-hook #'ws-butler-mode)
(add-hook 'vue-mode-hook #'yas-minor-mode)

(eval-after-load 'vue-mode
  '(add-hook 'vue-mode-hook #'add-node-modules-path))

(with-eval-after-load 'flycheck
  (flycheck-add-mode 'javascript-eslint 'vue-mode)
  (flycheck-add-mode 'javascript-eslint 'vue-html-mode)
;;  (flycheck-add-mode 'typescript-tslint 'vue-mode)
  (flycheck-add-mode 'javascript-eslint 'css-mode))
  
(add-hook 'vue-mode-hook 'flycheck-mode)
(add-hook 'vue-mode-hook 'emmet-mode)

(add-hook 'vue-html-mode-hook #'emmet-mode)

;;(add-hook 'vue-mode-hook #'setup-just-tide-mode)

(setq projectile-switch-project-action 'projectile-dired)
(setq projectile-enable-caching t)
;;(add-to-list 'projectile-globally-ignored-directories "node_modules")
;;(add-to-list 'projectile-globally-ignored-directories "dist")
;;(add-to-list 'projectile-globally-ignored-directories "node_modules")

(defadvice projectile-on (around exlude-tramp activate)
    (unless  (--any? (and it (file-remote-p it))
        (list
            (buffer-file-name)
            list-buffers-directory
            default-directory))
    ad-do-it))

;;(require 'undo-tree)
;;(global-undo-tree-mode 1)
;;(diminish 'undo-tree-mode)

;; install packages if they are not installed yet
(require 'elget-loader)
(install-and-load packages-to-load)

(require 'tramp)
(setq tramp-default-method "ssh")
(setq password-cache-expiry nil)
(setq tramp-verbose 6)

;;(setq projectile-indexing-method 'native)
(projectile-global-mode)

;; no startup msg  
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;; disable top menu 
(menu-bar-mode -99)

;; ido
(ido-mode t)
;(ido-everywhere 1)
(ido-vertical-mode t)
(diredp-toggle-find-file-reuse-dir 1)
(flx-ido-mode 1)
(setq ido-use-faces nil)

(package-initialize)

(super-save-mode 1)

;;(setq mode-icons-desaturate-active t)
;;(mode-icons-mode t)

(require 'bind-key)
(require 'js-beautify)
;;(set-default-font "Inconsolata LGC 10")
;;(set-default-font "Fira Code Medium 13")
(set-default-font "Hack 10")
(add-to-list 'default-frame-alist
             '(font . "Hack 10"))

;;(set-frame-font "Hack:pixelsize=12")

(require 'spaceline-config)

(setq-default mode-line-format '("%e" (:eval (spaceline-ml-main))))

  ;;(spaceline-helm-mode 1)
(spaceline-emacs-theme)

(require 'orginit)
(require 'fb2-reader)

(delete-selection-mode)

(require 'uniquify)
(setq 
  uniquify-buffer-name-style 'post-forward
  uniquify-separator ":")

;; create some frames with different color themes
;; (setq color-theme-is-global nil)

;; erlang
(defun start-erlang ()
  (interactive)
  (setq load-path (cons "/usr/local/lib/erlang/lib/tools-2.6.11/emacs/" load-path))
  (setq erlang-root-dir "/usr/local/lib/erlang")
  (setq
   exec-path (cons "/usr/local/lib/erlang/bin" exec-path))
  (require 'erlang-start)
  (require 'erlang-flymake))

;; tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)
(setq tab-always-indent 'complete)
(setq indent-line-function 'insert-tab)

(defun add-pretty-symbols ()
  "make some word or string show as pretty Unicode symbols"
  (setq prettify-symbols-alist
        '(
          (">=" . ?≥)
          ("lambda" . 955) ; λ
          ("->" . 8594)    ; →
          ("=>" . 8658)    ; ⇒
          ("map" . 8614)   ; ↦
          )))

(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.js[x]?\\'")))
  (emmet-mode t)
  (add-pretty-symbols)
  (setq web-mode-enable-current-element-highlight t)
  (prettify-symbols-mode)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4))

(add-hook 'web-mode-hook 'my-web-mode-hook)

(put 'upcase-region 'disabled nil)

(require 'wrap-region)
(wrap-region-add-wrapper "/* " " */" "#" '(javascript-mode css-mode js2-mode))
(global-set-key (kbd "M-a") 'smex)

(setq-default cycle-bg-colors '("#111122" "#112211" "#221122" "#112222" "#00587b" "#004b15"))
(require 'cycle-bg-colors)

(require 'swissknife)
(require 'etags-select)
(require 'autocommit)
(require 'issue-link)
(require 'ws-butler)
(require 'copy-as-format)

(add-hook 'prog-mode-hook 'issue-link-mode) ;; converts issue lables into buttons

(setq-default dired-details-hidden-string "--- ")
(dired-details-install)
(setq dired-dwim-target t)

;; backup tuning
;; Store backups and auto-saved files in TEMPORARY-FILE-DIRECTORY (which defaults to /tmp on Unix), instead of in the same directory as the file.
(setq make-backup-files nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Ask y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

(setq jit-lock-defer-time 0)
(setq fast-but-imprecise-scrolling t)

(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

;; show full path in frame title for current buffer
(setq frame-title-format
  '(:eval
    (if buffer-file-name
        (replace-regexp-in-string
         "\\\\" "/"
         (replace-regexp-in-string
          (regexp-quote (getenv "HOME")) "~"
          (convert-standard-filename buffer-file-name)))
      (buffer-name))))

;; (color-theme-parus)

(setq-default frame-title-format "%b (%f)")

(setenv "webdriver.chrome.driver" "/usr/lib/chromium/chromedriver")
(getenv "webdriver.chrome.driver")

(getenv "HOME")

(setenv "PATH"
        (concat "/bin:"
                (concat (getenv "HOME") "/.nvm:")
                "/home/mico/.nvm/versions/node/v9.11.2/bin:"
                (getenv "PATH")))

;; export NVM_DIR="$HOME/.nvm"
(setenv "NVM_DIR" (concat (getenv "HOME") "/.nvm"))
 
;; elfeed
(setq elfeed-feeds
        '(("http://nullprogram.com/feed/" emacs)
        ("http://habrahabr.ru/rss/company/kolibrios/blog/" kolibri)
        ("http://planet.emacsen.org/atom.xml" emacs)
        ("http://emacsredux.com/atom.xml" emacs)
        ("karl-voit.at/feeds/lazyblorg-all.atom_1.0.links-only.xml" emacs)
        ("http://sachachua.com/blog/category/geek/emacs/feed/" emacs)))

(require 'keymap)
(setq vc-svn-diff-switches "-x --ignore-eol-style")
;;exec-path
(put 'downcase-region 'disabled nil)

(require 'buffer-move)
(require 'keyfreq)
(keyfreq-mode 1)
(keyfreq-autosave-mode 1)

(require 'json-reformat)

(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'transpose-frame)

;; use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

(require 'multi-eshell)

(if (file-exists-p "~/.emacs.d/lisp/elisp-private/main.el")
    (load "elisp-private/main")
  (error "Run git clone https://github.com/shevchuk/elisp-private in ./lisp folder"))

(require 'tscript)
(require 'golang)
(require 'macros)
(require 'eshell-misc)
(require 'editor)

(setq transient-mark-mode t)
(tool-bar-mode -1)

;; Use font-lock everywhere.
(global-font-lock-mode t)

;; We have CPU to spare; highlight all syntax categories.
(setq font-lock-maximum-decoration t)

;; dracula is a nice vibrant dark blue theme
(require 'dracula-theme)

(setq-default cursor-type 'box) ;; bar
;;(blink-cursor-mode 2)
(set-cursor-color "#33ff00")
