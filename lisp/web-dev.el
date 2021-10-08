(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-content-types-alist
        '(("jsx" . "\\.js[x]?\\'")))
  (emmet-mode t)
  (add-pretty-symbols)
  (setq web-mode-enable-current-element-highlight t)
  (prettify-symbols-mode)
  (setq web-mode-markup-indent-offset 4)
  (setq web-mode-css-indent-offset 4)
  (setq web-mode-code-indent-offset 4))

(add-hook 'web-mode-hook 'my-web-mode-hook)

(provide 'web-dev)
