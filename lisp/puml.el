(add-hook 'plantuml-mode-hook 'plantuml-mode-keys)
(defun plantuml-mode-keys ()
  "plantuml keybindings"
  (local-set-key (kbd "M-g") 'plantuml-preview))

(setq plantuml-jar-path "/home/mico/scripts/puml/plantuml.jar")
(setq plantuml-default-exec-mode 'jar)

(with-eval-after-load 'flycheck
  (require 'flycheck-plantuml)
  (flycheck-plantuml-setup))

(provide 'puml)
