(setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log"))
;;(setq tide-tsserver-executable "/home/mico/.nvm/versions/node/v9.11.2/bin/tsserver")

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

(defun setup-just-tide-mode ()
  (interactive)
  (run-at-time "5 sec" nil #'tide-setup)
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
;;(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
;;(add-hook 'vue-mode-hook #'setup-just-tide-mode)




;;(add-hook 'tide-mode-hook #'tide-restart-server)
