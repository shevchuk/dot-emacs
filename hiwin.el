(defvar hiwin-color       "gray30")  ;; $BHs%"%/%F%#%V(Bwindow$B$NGX7J?'(B
(defvar hiwin-overlay-num  8)        ;; $BHs%"%/%F%#%V(Bwindow$B$N(Boverlay$B?t(B
(defvar hiwin-face         nil)      ;; $BHs%"%/%F%#%V(Bwindow$BMQ(Bface
(defvar hiwin-overlay      nil)      ;; $BHs%"%/%F%#%V(Bwindow$BMQ(Boverlay
(defvar hiwin-window       nil)      ;; $B%"%/%F%#%V(Bwindow$B$N(Bwindow
(defvar hiwin-buffer       nil)      ;; $B%"%/%F%#%V(Bwindow$B$N(Bbuffer
(defvar hiwin-ignore-buffer '("+draft/1" "+draft/2" "+draft/3"))

(defun hiwin-init ()
  ;; $BHs%"%/%F%#%V(Bwindow$BMQ(Bface$B$r:n@.(B
  (make-face 'hiwin-face)
  ;; $BHs%"%/%F%#%V(Bwindow$BMQ(Bface$B$NGX7J?'$r@_Dj(B
  (set-face-background 'hiwin-face hiwin-color)
  (let ((num 0)      ;; $B%+%&%s%?(B
        (buf nil))   ;; $B:n6HMQ%P%C%U%!(B
    ;; $B:n6HMQ%P%C%U%!$r:n@.(B
    (setq buf (get-buffer-create "*hiwin-temp*"))
    ;; $B:n@.$9$k(Boverlay$BJ,$r=hM}!J%k!<%W3+;O!K(B
    (while (< num hiwin-overlay-num)
      ;; $BHs%"%/%F%#%V(Bwindow$BMQ(Boverlay$B$r:n@.(B
      (setq hiwin-overlay (cons (make-overlay 1 1 buf nil t) hiwin-overlay))
      ;; $BHs%"%/%F%#%V(Bwindow$BMQ(Boverlay$B$NK\J8$N(Bface$B$r@_Dj(B
      (overlay-put (nth 0 hiwin-overlay) 'face 'hiwin-face)
      ;; $BHs%"%/%F%#%V(Bwindow$BMQ(Boverlay$B$N(BEOF$B$N(Bface$B$r@_Dj(B
      (overlay-put (nth 0 hiwin-overlay) 'after-string
                   (propertize (make-string 100 ?\n) 'face 'hiwin-face))
      ;; $B%+%&%s%?%"%C%W(B
      (setq num (1+ num))
      ) ;; $B!J%k!<%W=*N;!K(B
    ;; $B:n6HMQ%P%C%U%!$r:o=|(B
    (kill-buffer buf)
    )
  )

(defun hiwin-load ()
  ;; $B%"%/%F%#%V(Bwindow$B$N(Bwindow$B$r<hF@(B
  (setq hiwin-window (selected-window))
  ;; $B%"%/%F%#%V(Bwindow$B$N(Bbuffer$B$r<hF@(B
  (setq hiwin-buffer (current-buffer))
  (let ((num 0)                         ;; $B%+%&%s%?(B
        (target-window nil)             ;; $B=hM}BP>](Bwindow
        (target-list (window-list)))    ;; $BI=<((Bwindow$B$N%j%9%H(B
    ;; $BI=<((Bwinndow$B$N$9$Y$F$r=hM}!J%k!<%W3+;O!K(B
    (while target-list
      ;; $B=hM}BP>](Bwindow$B$r<hF@(B
      (setq target-window (car target-list))
      ;; $B=hM}BP>](Bwindow$B$r%j%9%H$+$i:o=|(B
      (setq target-list (cdr target-list))
      ;; $B=hM}BP>](Bwindow$B$H%"%/%F%#%V(Bwindow$B$,0lCW$9$k>l9g(B
      (if (eq target-window hiwin-window)
          ;; EOB$B0l$DA0$N>l9g!$0lJ8;z?J$`(B
          (progn (if (eq (point) (1- (point-max))) (forward-char 1) ) )
        ;; $B=hM}BP>](Bwindow$B$H%"%/%F%#%V(Bwindow$B$,0lCW$7$J$$>l9g(B
        (progn
          (let ((buf (window-buffer target-window)))
            (if (member buf hiwin-ignore-buffer)
                ()
              ;; $B=hM}BP>](Bwindow$B$r%"%/%F%#%V2=(B
              (select-window target-window)
              ;; EOB$B$N>l9g!$0lJ8;zLa$k(B
              (if (eq (point) (point-max)) (backward-char 1) )
              ;; $B=hM}BP>](Bwindow$B$K(Boverlay$B$r@_Dj(B
              (move-overlay (nth num hiwin-overlay)
                            (point-min) (point-max) (current-buffer))
              (overlay-put (nth num hiwin-overlay) 'window target-window)
              ;; $B%+%&%s%?%"%C%W(B
              (setq num (1+ num))
              )
            )
          )
        )
      ) ;; $B!J%k!<%W=*N;!K(B
    ;; $B%"%/%F%#%V(Bwindow$B$r%"%/%F%#%V2=(B
    (select-window hiwin-window)
    )
  )

(defun hiwin-unload ()
  (let ((num 0))   ;; $B%+%&%s%?(B
    ;; $B:n@.$5$l$?(Boverlay$BJ,$r=hM}!J%k!<%W3+;O!K(B
    (while (< num hiwin-overlay-num)
      ;; $BHs%"%/%F%#%V(Bwindow$BMQ(Boverlay$B$r:o=|(B
      (delete-overlay (nth num hiwin-overlay))
      ;; $B%+%&%s%?%"%C%W(B
      (setq num (1+ num))
      )) ;; $B!J%k!<%W=*N;!K(B
  ;; $BHs%"%/%F%#%V(Bwindow$BMQ(Boverlay$B$NJQ?t$r=i4|2=(B
  (setq hiwin-overlay nil)
  )

(defun hiwin-highlight-window ()
  ;; $B%"%/%F%#%V(Bwindow$B$,%_%K%P%C%U%!$N%&%#%s%I%&$N>l9g!$(B
  ;; $B$"$k$$$OJL$N%&%#%s%I%&$N>l9g$K=hM}(B
  (unless (or (eq (selected-window) (minibuffer-window))
              (and (eq hiwin-window (selected-window))
                   (eq hiwin-buffer (current-buffer))))
    ;; $BHs%"%/%F%#%V(Bwindow$BMQ(Boverlay$B$NJQ?t$,(Bnull$B$N>l9g!$=i4|2=(B
    (if (null hiwin-overlay) (hiwin-init))
    ;; $BHs%"%/%F%#%V(Bwindow$B$N(Boverlay$B$r@_Dj(B
    (hiwin-load)
    )
  )

(defun hiwin-mode ()
  (interactive)
  (if (not (null hiwin-overlay))
      (progn (remove-hook 'post-command-hook 'hiwin-highlight-window)
             (hiwin-unload))
    (add-hook 'post-command-hook 'hiwin-highlight-window)
    (hiwin-highlight-window)))

(defadvice split-window-vertically (around split-window-vertically-around)
  (interactive) ad-do-it (hiwin-load) )
(ad-activate 'split-window-vertically)

(defadvice split-window-horizontally (around split-window-horizontally)
  (interactive) ad-do-it (hiwin-load) )
(ad-activate 'split-window-horizontally)

(defadvice delete-window (around delete-window)
  (interactive) ad-do-it (hiwin-mode) (hiwin-mode))
(ad-activate 'delete-window)

(defadvice recenter (around recenter-around)
  (interactive) (progn ad-do-it (hiwin-load)) )
(ad-activate 'recenter)

(hiwin-mode)
