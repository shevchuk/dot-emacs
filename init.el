;; ElHome
(defconst elhome-directory "~/.emacs.d/")

(add-to-list 'load-path (concat (file-name-as-directory elhome-directory) "el-get/el-get"))
(setq el-get-git-install-url "git://github.com/dimitri/el-get.git")

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

(push (concat elhome-directory "/site-lisp/recipes/") el-get-recipe-path)

(setq my-mach-packages '(magit vkill))

(setq my-packages
      (append my-mach-packages
              '(expand-region
		tern
		js2-mode
		dsvn
                elhome
                )
              (mapcar 'el-get-source-name el-get-sources)))
(add-hook 'el-get-post-install-hooks 'el-get-init)
;; you should be connected to Net at this point
(el-get 'sync my-packages)

(require 'elhome)
(elhome-init)
