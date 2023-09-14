;(add-hook 'after-init-hook 'global-company-mode)
;(add-hook 'after-init-hook 'global-diff-hl-mode)

;(add-hook 'prog-mode-hook 'lsp-deferred)
(add-hook 'prog-mode-hook #'ws-butler-mode)
(add-hook 'prog-mode-hook #'smartparens-mode)
(add-hook 'prog-mode-hook #'whitespace-mode)
(add-hook 'prog-mode-hook #'linum-mode)
(add-hook 'prog-mode-hook #'linum-relative-mode)

;(add-hook 'prog-mode-hook #'auto-highlight-symbol-mode)
;(add-hook 'prog-mode-hook #'highlight-parentheses-mode)
;(add-hook 'prog-mode-hook #'column-number-mode)
;(add-hook 'prog-mode-hook #'emmet-mode)
;(add-hook 'prog-mode-hook #'hl-line-mode)

;(add-to-list 'auto-mode-alist '("\\.es6\\'" . js2-mode))
;(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))
;(add-to-list 'auto-mode-alist '("\\.vue\\'" . vue-mode))
;(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
;(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
;(add-to-list 'auto-mode-alist '("\\.flow\\'" . js2-mode))
;(add-to-list 'auto-mode-alist '("\\.php\\'" . php-mode))
;(add-to-list 'auto-mode-alist '("\\.jira\\'" . jira-markup-mode))
;(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))
;(add-to-list 'auto-mode-alist '("\\.feature\\'" . gherkin-mode))
;(add-to-list 'auto-mode-alist '("\\.puml\\'" . plantuml-mode))

;(add-hook 'sh-mode-hook 'flycheck-mode)

;(add-hook 'terraform-mode-hook
;    (lambda ()
;        (lsp)
;        (lsp-register-client
;            (make-lsp-client :new-connection (lsp-stdio-connection '("/home/mico/bin/tf-lsp/terraform-lsp" "-enable-log-file"))
;                  :major-modes '(terraform-mode)
;                  :server-id 'terraform-ls))))




;(add-hook 'magit-post-refresh-hook 'diff-hl-magit-post-refresh)

;; javascript
;(add-hook 'js2-mode-hook
;          (lambda ()
;            (define-key js2-mode-map (kbd "RET") 'newline-and-indent)
;            (wrap-region-mode t)
;            (js2-refactor-mode t)
;            (flow-js2-mode t)
 ;           ;; Activate the folding mode
  ;          (hs-minor-mode t)
   ;         (rjsx-minor-mode t)
    ;        (flycheck-mode 1)
     ;       ))

(provide 'prog-mode-hooks)
