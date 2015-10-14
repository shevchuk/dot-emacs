(setq eshell-history-size nil)

(add-hook 'eshell-mode-hook
          #'(lambda ()
              (face-remap-add-relative 'mode-line '((:foreground "ivory" :background "DarkOrange4") mode-line))
              (setq pcomplete-cycle-completions nil)
              (eshell-command "export LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH")))

(defadvice pcomplete (around avoid-remote-connections activate)
   (let ((file-name-handler-alist (copy-alist file-name-handler-alist)))
     (setq file-name-handler-alist
           (delete (rassoc 'tramp-completion-file-name-handler
                           file-name-handler-alist) file-name-handler-alist))
     ad-do-it))

