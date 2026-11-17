;; ai.el --- ECA AI assistant configuration  -*- lexical-binding: t; -*-

;; ECA is a package that works like AI assistant for code completion within Emacs.
;; It provides inline suggestions as you type, which can be accepted or dismissed.

;;; Code:

(require 'json)
(require 'face-remap)

;;;; Pleasant ding when ECA finishes a reply

(defcustom ai-eca-ding-sound "/usr/share/sounds/freedesktop/stereo/complete.oga"
  "Sound file played when ECA chat finishes and is ready for a new prompt.
Other nice candidates: bell.oga, message-new-instant.oga from the
same freedesktop sound directory."
  :type 'file)

(defun ai-eca-ding ()
  "Play a short, pleasant ding.  Async and non-blocking."
  (let ((file ai-eca-ding-sound))
    (when (and file (file-exists-p file))
      (if (executable-find "paplay")
          (start-process "eca-ding" nil "paplay" file)
        (when (fboundp 'play-sound-file)
          (run-at-time 0 nil #'play-sound-file file))))))

;;;; ashell panel indicator (grey/red/green circle)
;; Driven by ~/.config/ashell/scripts/eca-indicator.sh

(defcustom ai-eca-indicator-script
  (expand-file-name "~/.config/ashell/scripts/eca-indicator.sh")
  "Script controlling the ECA status circle in the ashell panel."
  :type 'file)

(defun ai-eca-indicator--call (subcommand &optional id)
  "Call the indicator script's SUBCOMMAND with worker ID.
ID defaults to this Emacs's PID.  Returns the first stdout line, or
nil if the script is unavailable/failed."
  (when (and ai-eca-indicator-script
             (file-executable-p ai-eca-indicator-script))
    (condition-case err
        (car (process-lines ai-eca-indicator-script
                            subcommand (or id (number-to-string (emacs-pid)))))
      (error (message "eca-indicator: %S" err) nil))))

(defvar ai-eca--chat-counter 0
  "Monotonic counter making per-chat worker ids unique within this Emacs.")

(defvar-local ai-eca--chat-id nil
  "Worker id (\"PID-COUNTER\") naming this chat buffer's marker file.")

(defun ai-eca--chat-id ()
  "Return this chat buffer's worker id, allocating one on first use.
The indicator script keeps one marker file per id, so parallel chats
in the same Emacs no longer share (and prematurely drop) a single
per-PID marker."
  (or ai-eca--chat-id
      (setq-local ai-eca--chat-id
                  (format "%d-%d" (emacs-pid)
                          (setq ai-eca--chat-counter
                                (1+ ai-eca--chat-counter))))))

(defun ai-eca-indicator--script-available-p ()
  "Non-nil when the indicator script exists and is executable."
  (and ai-eca-indicator-script
       (file-executable-p ai-eca-indicator-script)))

(defun ai-eca-indicator-idle ()
  "ECA initialized: drop our marker; grey unless another instance works."
  (ai-eca-indicator--call "idle"))

(defun ai-eca-indicator-working ()
  "This Emacs started processing a prompt: red circle.
Safe with multiple instances: each chat buffer owns one PID-COUNTER
marker file in the indicator script's work dir."
  (ai-eca-indicator--call "start" (ai-eca--chat-id)))

(defun ai-eca-indicator-finished ()
  "A chat finished.  Green circle + ding only if it was the last one.
Always drops this chat's marker (the script ignores markers of dead
processes), so a lingering sibling or crashed Emacs can no longer
mute the ding forever."
  (let ((answer (ai-eca-indicator--call "finish" (ai-eca--chat-id))))
    ;; Ding when this was the last worker everywhere, or if the script
    ;; is missing entirely (keep the old always-ding behavior then).
    (when (or (string= answer "green")
              (and (null answer) (not (ai-eca-indicator--script-available-p))))
      (ai-eca-ding))))

(defun ai-eca-indicator-buffer-killed ()
  "Drop this chat's marker when its buffer is killed mid-prompt."
  (when ai-eca--chat-id
    (ai-eca-indicator--call "finish" ai-eca--chat-id)))

(defun ai-eca-indicator-chat-loading (orig-fn session loading)
  "Advice around `eca-chat--set-chat-loading': red when loading starts.
SESSION and LOADING are passed through to ORIG-FN untouched."
  (when (eq loading t)
    (ai-eca-indicator-working))
  (funcall orig-fn session loading))

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
  (advice-add 'eca-chat--set-chat-loading :around
              #'ai-eca-indicator-chat-loading)
  (define-key eca-chat-mode-map (kbd "C-t") #'eca-chat-talk)
  (add-hook 'eca-chat-finished-hook #'ai-eca-indicator-finished)
  (add-hook 'eca-after-initialize-hook #'ai-eca-indicator-idle)
  (add-hook 'kill-buffer-hook #'ai-eca-indicator-buffer-killed))

(add-hook 'eca-chat-tool-call-functions #'mt/eca-refresh-magit)

(provide 'ai)
