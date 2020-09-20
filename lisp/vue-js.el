(add-hook 'vue-mode-hook #'yas-minor-mode)

(eval-after-load 'vue-mode
  '(add-hook 'vue-mode-hook #'add-node-modules-path))

(add-hook 'vue-mode-hook 'flycheck-mode)
(add-hook 'vue-mode-hook 'emmet-mode)
(add-hook 'vue-html-mode-hook #'emmet-mode)

(provide 'vue-js)
