;; Allow 20MB of memory (instead of 0.76MB) before calling garbage collection. This means GC runs less often, which speeds up some operations.
(setq gc-cons-threshold 20000000)

(setq ring-bell-function 'ignore)
(server-start)

;; (set-background-color "lightblue")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp"))
;;; first run will install these

;; these packages will be automatically installed if there is an internet connection

(defvar packages-to-load
  '(
    elfeed ;; rss feed
    auto-complete
    buffer-move
    restclient
    color-theme
    diminish ;; hides modes from mode-line
    zoom-window
    sublime-themes
    ido-vertical-mode
    yaml-mode
    company-mode
    company-go
    flycheck
    multi-compile
    go-eldoc
    auto-complete
    super-save
    multi-eshell
    diff-hl
    unicode-fonts
    dsvn
    expand-region
    js2-mode
    json-mode
    jsx-mode
    rjsx-mode
    jira-markup-mode
    log4e
    yaxception
    tss
    go-mode
    ace-window
    yasnippet
    js2-refactor
    coffee-mode
    magit
    auto-highlight-symbol
    highlight-parentheses
    ;;tern
    grizzl
    flx
    smex
    unbound
    helm-swoop
    projectile
    dired+
    ;;wrap-region
    helm
    helm-projectile
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
    drag-stuff
    ;; themes
    monokai-theme
    fancy-narrow
    s
    dash
    annoying-arrows-mode
    powerline
    spaceline
    yandex-weather
    airline-themes
    anti-zenburn-theme
    dracula-theme
    moe-theme
    bind-key
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

(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (linum-mode 1)
            (diff-hl-mode 1)))

;; javascript
(add-hook 'js2-mode-hook 
          (lambda ()
            (auto-complete-mode 0)
            (yas-minor-mode)
            (define-key js2-mode-map (kbd "RET") 'newline-and-indent)
            (define-key js2-mode-map (kbd "C-r") 'run-skewer-repl)
            ;;(face-remap-add-relative 'mode-line '((:foreground "ivory" :background "DeepPink4") mode-line))
            ;;(define-key js2-mode-map (kbd "M-.") nil)
            (wrap-region-mode t)
            (linum-mode 1)
            (js2-refactor-mode t)
            ;;(tern-mode t)
            ;; Activate the folding mode
            (hs-minor-mode t)
            (diff-hl-mode 1)
            (tern-mode 1)
            ))

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

;;(eval-after-load 'tern
;;   '(progn
;;      (require 'tern-auto-complete)
;;      (tern-ac-setup)))

(add-hook 'after-init-hook 'global-company-mode)


;;(add-to-list 'company-backends 'company-tern)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))

(add-to-list 'auto-mode-alist '("\\.jira\\'" . jira-markup-mode))
             
;;(add-to-list 'auto-mode-alist '("\\.erl\\'" . js2-mode))

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

(scroll-lock-mode t)
;;(require 'undo-tree)
;;(global-undo-tree-mode 1)
;;(diminish 'undo-tree-mode)

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

(load "~/.emacs.d/go-snippets/go-snippets.el")

(require 'yasnippet)
(yas/reload-all)

;;(setq projectile-indexing-method 'native)
(projectile-global-mode)

;; no startup msg  
(setq inhibit-startup-message t)
(setq initial-scratch-message "")
;; disable top menu 
(menu-bar-mode -99)

(setq column-number-mode 1)
;; ido
(ido-mode t)
(ido-everywhere 1)
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
(set-default-font "Input Mono Narrow 13")
(add-to-list 'default-frame-alist
             '(font . "Input Mono Narrow 13"))

;;(set-frame-font "Hack:pixelsize=12")

(require 'spaceline-config)
(spaceline-spacemacs-theme)

(require 'orginit)
;; эта часть настроек для доступа к Gmail по IMAP
(setq elmo-imap4-default-server "imap.gmail.com"
      elmo-imap4-default-user "mikhail.shevchuk@gmail.com"
      elmo-imap4-default-authenticate-type 'clear
      elmo-imap4-default-port '993
      elmo-imap4-default-stream-type 'ssl
      elmo-imap4-use-modified-utf7 t)

;; тут настройки отвечающие за SMTP
(setq wl-smtp-connection-type 'starttls
      wl-smtp-posting-port 587
      wl-smtp-authenticate-type "plain"
      wl-smtp-posting-user "mikhail.shevchuk"
      wl-smtp-posting-server "smtp.gmail.com"
      wl-local-domain "gmail.com"
      wl-message-id-domain "smtp.gmail.com")

(setq wl-from "Mike Shevchuk"

    ;; настройки папок IMAP
    ;; если у вас в настройках gmail стоит русский язык то копируйте все как есть
    ;; gmail создает имена папок в зависимости от локали
    wl-default-folder "%inbox"
    wl-draft-folder   "%[Gmail]/Черновики"
    wl-trash-folder   "%[Gmail]/Корзина"
    wl-fcc            "%[Gmail]/Отправленные"

    wl-fcc-force-as-read    t
    wl-default-spec "%")

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
(setq-default tab-width 4)
(setq tab-always-indent 'complete)
(setq indent-line-function 'insert-tab)

(put 'upcase-region 'disabled nil)

(require 'wrap-region)
(wrap-region-add-wrapper "/* " " */" "#" '(javascript-mode css-mode js2-mode))
(global-set-key (kbd "M-a") 'smex)

(setq-default cycle-bg-colors '("#111122" "#112211" "#221122" "#112222" "#00587b" "#004b15"))
(require 'cycle-bg-colors)

(require 'swissknife)
(require 'etags-select)
(require 'autocommit)

;; backup tuning
;; Store backups and auto-saved files in TEMPORARY-FILE-DIRECTORY (which defaults to /tmp on Unix), instead of in the same directory as the file.
(setq make-backup-files nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; Ask y/n instead of yes/no
(fset 'yes-or-no-p 'y-or-n-p)

;;(require 'daylight)
;;
;;(setq daylight-morning-theme 'color-theme-scintilla
;;      daylight-af
;;oon-theme 'color-theme-aalto-light
;;      daylight-evening-theme 'color-theme-parus
;;      daylight-late-theme 'color-theme-comidia)
;;
;;(daylight-mode 1)

;; (require 'persp-projectile)
;;(require 'tern)
;; yasnippet

;; theme setup
;;(load-theme 'hickey t) ;; looks nice, dark one
;;(load-theme 'flatui t) ;; not bad, lighter (grey) with no major bugs
;;(require 'moe-theme)

;;(fringe-mode '(17 . 0))

;;(setq default-frame-alist
;;      '(
;;        (scroll-bar-width . 8)
;;        ))

 ;; scroll one line at a time (less "jumpy" than defaults)
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


(setenv "LD_LIBRARY_PATH"
        (concat
         "/opt/oracle/instantclient" ":"
         (getenv "LD_LIBRARY_PATH")))

(setenv "OCI_LIB_DIR"
        "/opt/oracle/instantclient")

(setenv "OCI_INC_DIR"
        "/opt/oracle/instantclient/sdk/include")

;; export NVM_DIR="$HOME/.nvm"
(setenv "NVM_DIR" (concat (getenv "HOME") "/.nvm"))
 
;; elfeed
(setq elfeed-feeds
      '(("http://alkatrion.com/?feed=rss2" velo)
        ("http://nullprogram.com/feed/" emacs)
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

(setenv "PATH"
  (concat "/bin:"
          (getenv "PATH")))
        
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(require 'transpose-frame)

;; use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

(setq-default cursor-type 'bar) 
(blink-cursor-mode 1)
(set-cursor-color "#000077")

;;(add-to-list 'load-path
;;             "/home/mico/.emacs.d/contrib/ecb")

;;(require 'ecb)

;;(require 'tumblesocks)
;;(setq tumblesocks-blog "micoblog.tumblr.com")

(require 'multi-eshell)
(require 'nordigy)

(setq transient-mark-mode t)
(drag-stuff-global-mode t)
(drag-stuff-define-keys)
;; (require 'hiwin)
;; (hiwin-mode t)

(require 'tscript)
(tool-bar-mode -1)

(require 'golang)

(require 'macros)
(require 'eshell-misc)


(auto-highlight-symbol-mode t)
(highlight-parentheses-mode t)

;; Emacs gets annoyed when you navigate around your document one char at a time. 
(annoying-arrows-mode t)

;Авто определение формата по расширению файла
(add-to-list 'auto-mode-alist '(".fb2$" . fb2-mode-view))
 
;Функция для файлов .fb2 в режиме просмотра
 (defun fb2-mode-view()
     (vc-toggle-read-only)
     (interactive)
     (sgml-mode)
     (sgml-tags-invisible 0))
 
;Функция для файлов .fb2 в режиме редактирования
(defun fb2-mode-edit()
     (vc-toggle-read-only nil)
     (interactive)
     (sgml-mode)
     (sgml-tags-invisible 0))


;;(require 'sqlplus)

;; https://github.com/kuanyui/moe-theme.el
;;(require 'moe-theme)
;;(moe-light)
;;(moe-dark)
;;(load-theme 'moe-light)
;;(moe-theme-set-color 'yellow)
;;(powerline-moe-theme)
;;(moe-theme-set-color 'blue)

;;(smart-mode-line-powerline-theme)
;;(require 'material-light-theme)
;;(load-theme 'material-light)
;;(powerline-vim-theme)



;; use these together for anti-zenburn (grey colors)
;; <from here>
;;(require 'airline-themes)
;;(load-theme 'airline-sol)
;;(load-theme 'anti-zenburn)
;; <till here>

;; dracula is a nice vibrant dark blue theme
(require 'dracula-theme)
