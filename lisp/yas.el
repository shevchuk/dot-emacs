(add-hook 'prog-mode-hook #'yas-minor-mode)
(add-hook 'vue-mode-hook #'yas-minor-mode)
  
;;yasnippets
(message "yasnippet loaded")
(setq yas-snippet-dirs
  '("~/.emacs.d/yasnippets"))
(yas/reload-all)

(provide 'yas)
