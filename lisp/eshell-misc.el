(add-hook 'eshell-mode-hook
          #'(lambda () (eshell-command "export LD_LIBRARY_PATH=/opt/oracle/instantclient:$LD_LIBRARY_PATH")))
