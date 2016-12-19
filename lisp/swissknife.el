(setq jiralib-url "https://jira.ringcentral.com")


;; todo - move these into separate file
(defun toggle-kbd-macro-recording-on ()
  "One-key keyboard macros: turn recording on."
  (interactive)
  (define-key global-map (this-command-keys)
    'toggle-kbd-macro-recording-off)
  (start-kbd-macro nil))

(defun toggle-kbd-macro-recording-off ()
  "One-key keyboard macros: turn recording off."
  (interactive)
  (define-key global-map (this-command-keys)
    'toggle-kbd-macro-recording-on)
  (end-kbd-macro))

(defun isearch-yank-region ()
  (interactive)                                                                             
  (isearch-yank-internal (lambda () (mark)))
  (deactivate-mark))

(defun rotate-buffers ()
  "Rotate your windows"
  (interactive)
  (cond
   ((not (> (count-windows) 1))
    (message "You can't rotate a single window!"))
   (t
    (let ((i 0)
          (num-windows (count-windows)))
      (while  (< i (- num-windows 1))
        (let* ((w1 (elt (window-list) i))
               (w2 (elt (window-list) (% (+ i 1) num-windows)))
               (b1 (window-buffer w1))
               (b2 (window-buffer w2))
               (s1 (window-start w1))
               (s2 (window-start w2)))
          (set-window-buffer w1 b2)
          (set-window-buffer w2 b1)
          (set-window-start w1 s2)
          (set-window-start w2 s1)
          (setq i (1+ i))))))))

(defun increment-number-at-point ()
      (interactive)
      (skip-chars-backward "0123456789")
      (or (looking-at "[0123456789]+")
          (error "No number at point"))
      (replace-match (number-to-string (1+ (string-to-number (match-string 0))))))


(defun switch-buffers-between-frames ()
  "switch-buffers-between-frames switches the buffers between the two last frames"
  (interactive)
  (let ((this-frame-buffer nil)
	(other-frame-buffer nil))
    (setq this-frame-buffer (car (frame-parameter nil 'buffer-list)))
    (other-frame 1)
    (setq other-frame-buffer (car (frame-parameter nil 'buffer-list)))
    (switch-to-buffer this-frame-buffer)
    (other-frame 1)
    (switch-to-buffer other-frame-buffer)))

;; projectile tags generation
(defun my-create-tags-if-needed (SRC-DIR CTAGS-OPTS &optional FORCE)
  "return the full path of tags file"
  ;; TODO save the CTAGS-OPTS into hash
  (let ((dir (file-name-as-directory (file-truename SRC-DIR)) )
       file
       cmd)
    (setq file (concat dir "TAGS"))
    (when (or FORCE (not (file-exists-p file)))
      (setq cmd (format "find %s -type f -not -iwholename '*TAGS' -not -size +1024k | ctags -f %s -e  %s -L -" dir file CTAGS-OPTS))
      (shell-command cmd))
    file))

(defun projectile-generate-tags-in-this-project ()
  (interactive)
  (my-create-tags-if-needed (car (projectile-get-project-directories)) "" t))


(provide 'swissknife)
