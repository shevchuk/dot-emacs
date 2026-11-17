;;; early-init.el --- -*- lexical-binding: t; -*-
;; Emacs 31 warns about every file without a lexical-binding cookie.
;; This config relies on the (still default) dynamic binding, so silence it.
(setq warning-suppress-log-types
      (list (list (quote files) (quote missing-lexbind-cookie))
            ;; straight.el is bootstrapped in init.el but packages come from package.el
            (list (quote straight))))

;; Background native compilation of third-party packages emits lots of
;; harmless "function ... is not known to be defined" warnings (calls into
;; optional libraries).  Keep them in *Warnings* but don't pop up a window.
(setq native-comp-async-report-warnings-errors 'silent)
