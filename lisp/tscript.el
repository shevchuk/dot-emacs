(require 'jest-test-mode)

(add-hook 'typescript-mode-hook
          (lambda ()
            (flycheck-mode +1)
            (setq flycheck-check-syntax-automatically '(save mode-enabled))
            (eldoc-mode +1)
            (emmet-mode t)
            (jest-test-mode t)
            (lsp t)))

(provide 'tscript)
