;; org
(setq org-agenda-files (list "~/Documents/personal-notes/work.org"
                             "~/Documents/personal-notes/nodify.org"
                             "~/Documents/personal-notes/notes.org"
                             "~/Documents/personal-notes/today.org"
                             "~/Documents/personal-notes/later.org"
                             "~/Documents/personal-notes/inbox.org"
                             "~/Documents/personal-notes/thisweek.org"
                             "~/Documents/personal-notes/personal.org"))

(setq org-default-notes-file (concat "~/Documents/personal-notes/" "notes.org"))

(setq org-refile-targets (quote (("today.org" :maxlevel . 1) 
                              ("thisweek.org" :maxlevel . 1)
                              ("later.org" :maxlevel . 1))))

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

;;(org-babel-do-load-languages
;; 'org-babel-load-languages
;; '((ditaa . t))) ; this line activates ditaa

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

(setq org-startup-with-inline-images t)
(add-hook 'org-mode-hook 
          (lambda () 
            (when (eq system-type 'darwin) 
              (require 'unicode-fonts)
              (unicode-fonts-setup))
            (auto-revert-mode t)))
            ;;(add-hook 'after-save-hook 'autocommit-after-save-hook nil 'make-it-local)))

;; mobileorg

;; Set to the location of your Org files on your local system
(setq org-directory "~/Documents/personal-notes")
;; Set to the name of the file where new notes will be stored
(setq org-mobile-inbox-for-pull "~/Documents/personal-notes/from-mobile.org")
;; Set to <your Dropbox root directory>/MobileOrg.
(setq org-mobile-directory "~/Dropbox/Apps/MobileOrg")


;; reveal.js
(setq org-reveal-root "")
;; (setq org-html-htmlize-output-type 'inline-css) ;; default
(setq org-html-htmlize-output-type 'css)
;; (setq org-html-htmlize-font-prefix "") ;; default
(setq org-html-htmlize-font-prefix "org-")

;; org-ehtml (editable org pages - web interface)
;;(setq org-ehtml-docroot (expand-file-name "~/Documents/personal-notes/public/"))

;;(require 'org-ehtml)
;;(ws-start org-ehtml-handler 8887)



