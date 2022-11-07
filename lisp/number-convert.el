(defun convert-at-point (convert-fn)
  (let* ((bounds (if (use-region-p)
                     (cons (region-beginning) (region-end))
                   (bounds-of-thing-at-point 'word)))
         (text   (buffer-substring-no-properties (car bounds) (cdr bounds))))
    (when bounds
      (delete-region (car bounds) (cdr bounds))
      (insert (funcall convert-fn text)))))

(defun number-convert-hex-to-dec-at-point ()
  "Replaces decimal number with hex at point"
  (interactive)
  (convert-at-point (lambda (text)
                      (number-to-string (string-to-number text 16)))))

(defun number-convert-dec-to-hex-at-point ()
  "Replaces hex number with decimal at point"
  (interactive)
  (convert-at-point (lambda (text)
                      (format "%X" (string-to-number text)))))

