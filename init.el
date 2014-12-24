(server-start)
;; (set-background-color "lightblue")
(add-to-list 'load-path "~/.emacs.d")
;;; first run will install these

;; these packages will be automatically installed if there is an internet connection
(defvar packages-to-load
  '(
    color-theme
    jade-mode
    auto-complete
    multi-eshell
    unicode-fonts
    dsvn
    expand-region
    js2-mode
    json-mode
    log4e
    yaxception
    tss
    color-theme-buffer-local
    yasnippet
    js2-refactor
    coffee-mode
    ergoemacs-keybindings
    magit
    tern
    grizzl
    flx
    smex
    projectile
    wrap-region
    helm
    js-beautify
    rainbow-mode
    skewer-mode
    perspective
    keyfreq
    exec-path-from-shell
    nodejs-repl
    org-reveal
    wanderlust
    ztree
    htmlize
    smartparens
    leuven-theme
    tangotango-theme
    cyberpunk-theme
    ;;    uniquify
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


(add-hook
 'eshell-mode-hook
 (lambda ()
   (setq pcomplete-cycle-completions nil)))

(defadvice pcomplete (around avoid-remote-connections activate)
   (let ((file-name-handler-alist (copy-alist file-name-handler-alist)))
     (setq file-name-handler-alist
           (delete (rassoc 'tramp-completion-file-name-handler
                           file-name-handler-alist) file-name-handler-alist))
     ad-do-it))

;;yasnippets
(setq yas-snippet-dirs
      '("~/.emacs.d/yasnippets"))

(require 'yasnippet)
(yas/reload-all)

;;(setq projectile-indexing-method 'native)
(projectile-global-mode)

(setq column-number-mode 1)
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
                             "~/Documents/personal-notes/notes.org"
                             "~/Documents/personal-notes/personal.org"))

(setq org-default-notes-file (concat "~/Documents/personal-notes/" "notes.org"))

(add-hook 'text-mode-hook 'turn-on-auto-fill)
(add-hook 'text-mode-hook
          '(lambda() (set-fill-column 120)))

;;logging stuff
(setq org-log-done (quote time))
(setq org-log-into-drawer nil)
(setq org-log-redeadline (quote note))
(setq org-log-reschedule (quote time))
;todo keywords
(setq org-todo-keywords
      (quote ((sequence "TODO(t!)" "WAITING(w@/!)" "STARTED(s!)" "|" "DONE(d!/!)" "CANCELLED(c@/!)")
              (sequence "EXPIRED(E@)" "REJECTED(R@)"))))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((ditaa . t))) ; this line activates ditaa

(setq org-src-fontify-natively t)

;;; define categories that should be excluded
(setq org-export-exclude-category (list "google" "private"))

;;; define filter. The filter is called on each entry in the agenda.
;;; It defines a regexp to search for two timestamps, gets the start
;;; and end point of the entry and does a regexp search. It also
;;; checks if the category of the entry is in an exclude list and
;;; returns either t or nil to skip or include the entry.

(defun org-mycal-export-limit ()
  "Limit the export to items that have a date, time and a range. Also exclude certain categories."
  (setq org-tst-regexp "<\\([0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\} ... [0-9]\\{2\\}:[0-9]\\{2\\}[^\r\n>]*?\
\)>")
  (setq org-tstr-regexp (concat org-tst-regexp "--?-?" org-tst-regexp))
  (save-excursion
    ; get categories
    (setq mycategory (org-get-category))
    ; get start and end of tree
    (org-back-to-heading t)
    (setq mystart    (point))
    (org-end-of-subtree)
    (setq myend      (point))
    (goto-char mystart)
    ; search for timerange
    (setq myresult (re-search-forward org-tstr-regexp myend t))
    ; search for categories to exclude
    (setq mycatp (member mycategory org-export-exclude-category))
    ; return t if ok, nil when not ok
    (if (and myresult (not mycatp)) t nil)))

;;; activate filter and call export function
(defun org-mycal-export ()
  (let ((org-icalendar-verify-function 'org-mycal-export-limit))
    (org-icalendar-combine-agenda-files)))

(setq org-agenda-default-appointment-duration 60)

(setq org-icalendar-use-scheduled '(todo-start event-if-todo))

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

(require 'color-theme-buffer-local)
;; create some frames with different color themes
;; (setq color-theme-is-global nil)

(setq org-startup-with-inline-images t)
(add-hook 'org-mode-hook 
          (lambda () 
            (when (eq system-type 'darwin) 
              (require 'unicode-fonts)
              (unicode-fonts-setup))
            (auto-revert-mode t)))
            ;;(add-hook 'after-save-hook 'autocommit-after-save-hook nil 'make-it-local)))

;; reveal.js
(setq org-reveal-root "")

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

;;(require 'daylight)
;;
;;(setq daylight-morning-theme 'color-theme-scintilla
;;      daylight-afternoon-theme 'color-theme-aalto-light
;;      daylight-evening-theme 'color-theme-parus
;;      daylight-late-theme 'color-theme-comidia)
;;
;;(daylight-mode 1)

;; (require 'persp-projectile)
(require 'tern)
;; yasnippet

;; theme setup
;;(load-theme 'leuven t)
;;(load-theme 'cyberpunk t)

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

(color-theme-parus)

(setq-default frame-title-format "%b (%f)")

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

;; use Shift+arrow_keys to move cursor around split panes
(windmove-default-keybindings)

(require 'multi-eshell)
(require 'nordigy)

(require 'tscript)
(tool-bar-mode -1)
