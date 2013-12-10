;; ElHome
(defconst elhome-directory "~/.emacs.d/")

;; Additional custom recipes, not yet in the repository:
(setq el-get-sources
      '((:name wrap-region
	       :description "Wrap text with punctation or tag"
	       :type elpa
	       :prepare)
	(:name grizzl
               :type github
               :pkgname "d11wtq/grizzl")
	(:name flx
	       :type github
	       :pkgname "lewang/flx")
    (:name org-jira
           :type github
           :pkgname "baohaojun/org-jira")
    (:name js-beautify
       :type github
       :pkgname "einars/js-beautify")
	(:name flx-ido 
	       :description "flx-ido"
	       :type http
	       :url "https://github.com/lewang/flx/flx-ido.el"
	       :depends flx)
      ))

(defun install-elget () 
  (progn 
    (add-to-list 'load-path (concat (file-name-as-directory elhome-directory) "el-get/el-get"))

    (unless (require 'el-get nil t)
      (url-retrieve
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el"
       (lambda (s)
	 (let (el-get-master-branch)
	   (end-of-buffer)
	   (eval-print-last-sexp)))))
    (let ((emacswiki-recipes (concat el-get-dir "el-get/recipes/emacswiki")))
      (unless (file-exists-p emacswiki-recipes)
	(el-get-emacswiki-refresh emacswiki-recipes t)))
    (push (concat elhome-directory "/site-lisp/recipes/") el-get-recipe-path)))

(defun install-and-load (packages-to-load)
  (progn  
    (setq my-packages
	  (append
	   packages-to-load
	   '(elhome)
	   (mapcar 'el-get-source-name el-get-sources)))
    (add-hook 'el-get-post-install-hooks 'el-get-init)

    ;; you should be connected to internet at this point
    (el-get 'sync my-packages)
    
    (require 'elhome)
    (elhome-init)))

(install-elget)
(provide 'elget-loader)
