;;; early-init.el --- -*- lexical-binding: t; -*-
;; Emacs 31 warns about every file without a lexical-binding cookie.
;; This config relies on the (still default) dynamic binding, so silence it.
(setq warning-suppress-log-types
      (list (list (quote files) (quote missing-lexbind-cookie))
            ;; straight.el is bootstrapped in init.el but packages come from package.el
            (list (quote straight))))
