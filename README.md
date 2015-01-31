dot-emacs
=========

My current Emacs config

Install Inconsolata fonts
    
Run el-get-elpa-build-local-recipes to build all needed recipes

To get rid of the log-edit-mode error, delete the line
(eval-when-compile (log-edit-mode))
in the file ergoemacs-keybindings/ergoemacs-mode.el

Remap caps lock to alt key using this:

    Go into System Preferences
    Enter the Keyboard & Mouse preference pane
    In the Keyboard tab, click Modifier Keys...
    Swap the actions for Caps Lock and Control.
                    
In order to run tern correctly:
    - go into el-get/tern and run npm install there