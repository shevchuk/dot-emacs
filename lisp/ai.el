;; ai.el --- ECA AI assistant configuration  -*- lexical-binding: t; -*-

;; ECA is a package that works like AI assistant for code completion within Emacs.
;; It provides inline suggestions as you type, which can be accepted or dismissed.

;;; Code:

(require 'json)
(require 'face-remap)

(defun ai-eca-restart ()
  "Restart the current ECA session."
  (interactive)
  (when (and (fboundp 'eca-session) (eca-session))
    (eca-stop))
  (eca))

;;;; Header-line toolbar per-model background colors

(defconst ai-eca-model-bg-colors
  '(("z-ai-lite/GLM-5.1" . (:bg "#ff69b4"  :key-fg "blue" :value-fg "white"))
    ("z-ai-lite/GLM-5.2" . (:bg "#ff69b4"  :key-fg "blue" :value-fg "white"))
    ("z-ai-pro/GLM-5.1"  . (:bg "#ffff00"  :key-fg "violet"       :value-fg nil))
    ("z-ai-pro/GLM-5.2"  . (:bg "#ffff00"  :key-fg "violet"       :value-fg nil))
    )
  "Alist of (MODEL-REGEX . COLOR-PLIST) for ECA chat header-line styling.
Each MODEL-REGEX is matched case-insensitively against the current model name.
COLOR-PLIST keys:
  :bg       – background color (any value accepted by `face-background')
  :key-fg   – foreground color for option keys (model:, agent:, etc.)
  :value-fg – foreground color for option values (the actual model name, etc.).
              nil means keep the default foreground.")

(defun ai-eca--model-colors (model)
  "Return color plist for MODEL based on `ai-eca-model-bg-colors', or nil."
  (when model
    (cdr (seq-find (lambda (pair)
                     (let ((case-fold-search t))
                       (string-match-p (car pair) model)))
                   ai-eca-model-bg-colors))))

(defvar-local ai-eca--header-bg-cookie nil)
(defvar-local ai-eca--key-fg-cookie nil)
(defvar-local ai-eca--value-fg-cookie nil)

(defun ai-eca--remap-face (face cookie-var color-key colors)
  "Remap FACE using COLOR-KEY from COLORS plist, storing cookie in COOKIE-VAR.
Returns the new cookie, or nil if no remapping was done."
  (let ((cookie (symbol-value cookie-var)))
    (when cookie
      (condition-case nil
          (face-remap-remove-relative cookie)
        (error nil)))
    (set cookie-var nil)
    (when-let ((color (plist-get colors color-key)))
      (set cookie-var
           (face-remap-add-relative
            face `(:background ,(plist-get colors :bg) :foreground ,color))))))

(defun ai-eca--update-header-line (colors)
  "Update header-line faces according to COLORS plist in the current buffer.
If COLORS is nil, remove all previous remappings."
  ;; Always clear the header-line bg first.
  (when ai-eca--header-bg-cookie
    (condition-case nil
        (face-remap-remove-relative ai-eca--header-bg-cookie)
      (error nil))
    (setq ai-eca--header-bg-cookie nil))
  ;; Clear key/value remappings.
  (when ai-eca--key-fg-cookie
    (condition-case nil
        (face-remap-remove-relative ai-eca--key-fg-cookie)
      (error nil))
    (setq ai-eca--key-fg-cookie nil))
  (when ai-eca--value-fg-cookie
    (condition-case nil
        (face-remap-remove-relative ai-eca--value-fg-cookie)
      (error nil))
    (setq ai-eca--value-fg-cookie nil))
  ;; Apply new remappings.
  (when colors
    (let ((bg (plist-get colors :bg)))
      (setq ai-eca--header-bg-cookie
            (face-remap-add-relative 'header-line `(:background ,bg)))
      (when-let ((key-fg (plist-get colors :key-fg)))
        (setq ai-eca--key-fg-cookie
              (face-remap-add-relative
               'eca-chat-option-key-face `(:background ,bg :foreground ,key-fg))))
      (if-let ((value-fg (plist-get colors :value-fg)))
          (setq ai-eca--value-fg-cookie
                (face-remap-add-relative
                 'eca-chat-option-value-face `(:background ,bg :foreground ,value-fg)))
        ;; No value-fg specified: just match background so it doesn't look broken.
        (setq ai-eca--value-fg-cookie
              (face-remap-add-relative
               'eca-chat-option-value-face `(:background ,bg)))))))

(defun ai-eca-header-line-with-model-color (orig-fn session)
  "Advice around `eca-chat--header-line-string' to add per-model toolbar colors.
Remaps `header-line', `eca-chat-option-key-face', and
`eca-chat-option-value-face' using `face-remap-add-relative'."
  (when-let* ((result (funcall orig-fn session)))
    (let* ((model (eca-chat--model))
           (colors (ai-eca--model-colors model)))
      (ai-eca--update-header-line colors))
    result))

;;;; Keybindings

(use-package eca
  :vc (:url "https://github.com/editor-code-assistant/eca-emacs" :rev :newest)
  :bind (("C-c e r" . eca-rewrite))
  :config
  (advice-add 'eca-chat--header-line-string :around
              #'ai-eca-header-line-with-model-color)
  (define-key eca-chat-mode-map (kbd "C-t") #'eca-chat-talk))

(provide 'ai)
