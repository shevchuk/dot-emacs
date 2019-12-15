(add-to-list 'auto-mode-alist '(".fb2$" . fb2-mode-view))

(defun fb2-mode-view()
     (vc-toggle-read-only)
     (interactive)
     (sgml-mode)
     (sgml-tags-invisible 0))

(defun fb2-mode-edit()
     (vc-toggle-read-only nil)
     (interactive)
     (sgml-mode)
     (sgml-tags-invisible 0))
