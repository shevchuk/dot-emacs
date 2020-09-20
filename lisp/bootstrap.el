(if (file-exists-p "~/.emacs.d/lisp/elisp-private/main.el")
    (load "elisp-private/main")
  (error "Run git clone https://github.com/shevchuk/elisp-private in ./lisp folder"))

(provide 'bootstrap)
