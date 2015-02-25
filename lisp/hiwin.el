;;; hiwin.el --- Visible active window mode.

;; Copyright (C) 2009 ksugita
;;               2010 tomoya  <tomoya.ton@gmail.com>
;;               2010 ksugita <ksugita0510@gmail.com>
;;               2010 myuhe   <yuhei.maeda@gmail.com>

;; Author: ksugita
;; Keywords: faces, editing, emulating
;; Version: 1.02

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Usage
;; put followings your .emacs
;;   (require 'hiwin)
;;
;; if you visible active window, type M-x hiwin-mode.

;;; Changes
;; 2010-08-13 tomoya
;; myuhe $A$5$s$H(B ksugita $A$5$s$NP^U}$r%^$B!<$A%8(B
;;
;; 2010-08-13 ksugita
;; *Completions*$A1mJ>$(GUk$A$K(BMiniBuf$A$N1mJ>$,1@$l$k$N$rP^U}(B
;; $AJV$(GY/$A$G;-Cf%j%U%l%C%7%e$G$-$k$h$&(Bhiwin-refresh-win$A$r(Binteractive$A;/(B
;; $(GT6$AHK5D$J$(G]C$A6($@$C$?$?$a#,(Brecenter$A$N(Badvice$A$rOw3}(B
;;
;; 2010-08-11 myuhe
;; anything$(IJ=$(G]Y$A$N$(IJ=$AJ}$r$(I(M$APP$7$?$(GUk$A$K%_%K%P%C%U%!$,7G%"%/%F%#%V%&%#%s%I%&$H$7$F$(H$/$A$o$l$k$(GYBwn$A$rP^U}(B
;; anything$AFp$(GY/Uk$A$K(Banything$A%P%C%U%!RTMb$N%P%C%U%!$,7G%"%/%F%#%V%&%#%s%I%&$H$J$C$?$^$^$(I&($A$i$J$$$(GYBwn$A$rP^U}(B
;;
;; 2010-07-04 ksugita
;; $A%m$B!<$A%+%k$GTY%9%/%i%C%A$7$?%U%!%$%k$K(B tomoya$AJO#,(Bmasutaka$AJO$NP^U}$r74S3(B
;; readonly$A$J%"%/%F%#%V(Bwindow$A$N13>0I+$r$(G]C$A6($G$-$k$h$&$K$(Gq"$AD\$(I+y$A8|(B
;;
;; 2010-06-07 tomoya
;; $A%^%$%J$B!<$A%b$B!<$A%I;/(B
;;
;; 2009-09-13 ksugita
;; $A%V%m%0$G9+$(Gbd(B
;; http://ksugita.blog62.fc2.com/blog-entry-8.html


;;; Code:

(defvar hiwin-deactive-color "gray30"
  "$A7G%"%/%F%#%V(Bwindow$A$N13>0I+(B")
(defvar hiwin-readonly-color "#000030"
  "$BFI$A$_H!$j$B@l$ASC(Bwindow$A$N13>0I+(B")

(defvar hiwin-normal-color "#000030" ;;(background-color-at-point)
  "$(GUs$A$-$B9~$A$_?ID\(Bwindow$A$N13>0I+(B")
(defvar hiwin-ignore-buffer
  '(" *Minibuf-1*" "+draft/1" "+draft/2" "+draft/3")
  "$A%O%$%i%$%H$(I%\$AOsMb(Bbuffer")
(defvar hiwin-ol-count 8
  "$A7G%"%/%F%#%V(Bwindow$A$N(Boverlay$AJ}(B")
(defvar hiwin-ol-lines 128
  "$A7G%"%/%F%#%V(Bwindow$A$NPPJ}(B")

(defvar hiwin-temp-buf "*hiwin-temp*"
  "$AWw$(GdF$ASC%P%C%U%!(B")
(defvar hiwin-face nil
  "$A7G%"%/%F%#%V(Bwindow$ASC(Bface")
(defvar hiwin-ol nil
  "$A7G%"%/%F%#%V(Bwindow$ASC(Boverlay")
(defvar hiwin-window nil
  "$A%"%/%F%#%V(Bwindow$A$N(Bwindow")
(defvar hiwin-buffer nil
  "$A%"%/%F%#%V(Bwindow$A$N(Bbuffer")

(define-minor-mode hiwin-mode
  "Visible active window."
  :global t
  :lighter " hiwin"
  :group 'hiwin
  (hiwin))

(defun hiwin-create-ol ()
  ;; $A7G%"%/%F%#%V(Bwindow$ASC(Bface$A$rWw3I(B
  (make-face 'hiwin-face)
  ;; $A7G%"%/%F%#%V(Bwindow$ASC(Bface$A$N13>0I+$r$(G]C$A6((B
  (set-face-background 'hiwin-face hiwin-deactive-color)
  (let ((num 0)      ;; $A%+%&%s%?(B
        (buf nil))   ;; $AWw$(GdF$ASC%P%C%U%!(B
    ;; $AWw$(GdF$ASC%P%C%U%!$rWw3I(B
    (setq buf (get-buffer-create hiwin-temp-buf))
    ;; $AWw3I$9$k(Boverlay$A7V$r$B=h$A@m#(%k$B!<$A%W$(Gbd$AJ<#)(B
    (while (< num hiwin-ol-count)
      ;; $A7G%"%/%F%#%V(Bwindow$ASC(Boverlay$A$rWw3I(B
      (setq hiwin-ol (cons (make-overlay 1 1 buf nil t) hiwin-ol))
      ;; $A7G%"%/%F%#%V(Bwindow$ASC(Boverlay$A$N1>ND$N(Bface$A$r$(G]C$A6((B
      (overlay-put (nth 0 hiwin-ol) 'face 'hiwin-face)
      ;; $A7G%"%/%F%#%V(Bwindow$ASC(Boverlay$A$N(BEOF$A$N(Bface$A$r$(G]C$A6((B
      (overlay-put (nth 0 hiwin-ol) 'after-string
                   (propertize (make-string hiwin-ol-lines ?\n) 'face 'hiwin-face))
      ;; $A%+%&%s%?%"%C%W(B
      (setq num (1+ num))
      ) ;; $A#(%k$B!<$A%W$(G\\$AAK#)(B
    ;; $AWw$(GdF$ASC%P%C%U%!$rOw3}(B
    (kill-buffer buf)))

(defun hiwin-draw-ol ()
  ;; $A%"%/%F%#%V(Bwindow$A$N(Bwindow$A$rH!5C(B
  (setq hiwin-window (selected-window))
  ;; $A%"%/%F%#%V(Bwindow$A$N(Bbuffer$A$rH!5C(B
  (setq hiwin-buffer (current-buffer))
  (let ((num 0)                 ;; $A%+%&%s%?(B
        (win nil)               ;; $B=h$A@m$(I%\$AOs(Bwindow
        (lst (window-list)))    ;; $A1mJ>(Bwindow$A$N%j%9%H(B
    ;; $A1mJ>(Bwinndow$A$N$9$Y$F$r$B=h$A@m#(%k$B!<$A%W$(Gbd$AJ<#)(B
    (while lst
      ;; $B=h$A@m$(I%\$AOs(Bwindow$A$rH!5C(B
      (setq win (car lst))
      ;; $B=h$A@m$(I%\$AOs(Bwindow$A$r%j%9%H$+$iOw3}(B
      (setq lst (cdr lst))
      ;; $B=h$A@m$(I%\$AOs(Bwindow$A$H%"%/%F%#%V(Bwindow$A$,R;VB$9$k$(G^[$A:O(B
      (if (or (eq win hiwin-window) (eq win (minibuffer-window)))
          (progn
            ;; EOB$AR;$DG0$N$(G^[$A:O#,R;NDWV$(GbP$A$`(B
            (if (and (eq (point) (1- (point-max)))
                     (> (point-max) 1))
                (forward-char 1))
            ;; $BFI$A$_H!$j$B@l$ASC$+7q$+$G13>0I+$r$(I+y$A8|(B
            (if buffer-read-only
                (set-background-color hiwin-readonly-color)
              (set-background-color hiwin-normal-color)))
        ;; $B=h$A@m$(I%\$AOs(Bwindow$A$H%"%/%F%#%V(Bwindow$A$,R;VB$7$J$$$(G^[$A:O(B
        (progn
          (let ((buf (window-buffer win)))
            (if (member buf hiwin-ignore-buffer)
                ()
              ;; $B=h$A@m$(I%\$AOs(Bwindow$A$r%"%/%F%#%V;/(B
              (select-window win)
              ;; EOB$A$N$(G^[$A:O#,R;NDWV$(I&($A$k(B
              (if (and (eq (point) (point-max))
                       (> (point-max) 1))
                  (backward-char 1))
              ;; $B=h$A@m$(I%\$AOs(Bwindow$A$K(Boverlay$A$r$(G]C$A6((B
              (move-overlay (nth num hiwin-ol)
                            (point-min) (point-max) (current-buffer))
              (overlay-put (nth num hiwin-ol) 'window win)
              ;; $A%+%&%s%?%"%C%W(B
              (setq num (1+ num))
              ))))) ;; $A#(%k$B!<$A%W$(G\\$AAK#)(B
    ;; $A%"%/%F%#%V(Bwindow$A$r%"%/%F%#%V;/(B
    (select-window hiwin-window)))

(defun hiwin-delete-ol ()
  (let ((num 0))   ;; $A%+%&%s%?(B
    ;; $AWw3I$5$l$?(Boverlay$A7V$r$B=h$A@m#(%k$B!<$A%W$(Gbd$AJ<#)(B
    (while (< num hiwin-ol-count)
      ;; $A7G%"%/%F%#%V(Bwindow$ASC(Boverlay$A$rOw3}(B
      (delete-overlay (nth num hiwin-ol))
      ;; $A%+%&%s%?%"%C%W(B
      (setq num (1+ num))
      )) ;; $A#(%k$B!<$A%W$(G\\$AAK#)(B
  ;; $A7G%"%/%F%#%V(Bwindow$ASC(Boverlay$A$N$(I+y$AJ}$r3uFZ;/(B
  (setq hiwin-ol nil))

(defun hiwin-refresh-win ()
  (interactive)
  (let ((win (selected-window)) )
    ;; $A%_%K%P%C%U%!$+(Banything$A%P%C%U%!RTMb$r$(GrY$(I&1$A$7$F$$$k$(G^[$A:O(B
    (unless (or (eq win (minibuffer-window))
                (eq 1 (string-match "anything" (buffer-name (window-buffer win)))))
      ;; $(G\"$ATZ$N%&%#%s%I%&$,%"%/%F%#%V%&%#%s%I%&$N$(G^[$A:O(B
      ;; $A$+$D#,$(G\"$ATZ$N%P%C%U%!$,%+%l%s%H%P%C%U%!$N$(G^[$A:O(B
      (if (and (eq hiwin-window win) (eq hiwin-buffer (current-buffer)))
          ;; $BFI$A$_H!$j$B@l$ASC$+7q$+$G13>0I+$r$(I+y$A8|(B
          (if buffer-read-only
                (set-background-color hiwin-readonly-color)
              (set-background-color hiwin-normal-color)
              )
        ;; $ACh;-$r$(I(M$APP(B
        (hiwin-draw-ol)
        ))))

(defun hiwin ()
  (if (null hiwin-ol)
      (progn (hiwin-create-ol)
             (add-hook 'pre-command-hook  'hiwin-refresh-win)
             (add-hook 'post-command-hook 'hiwin-refresh-win)
             (add-hook 'window-configuration-change-hook 'hiwin-refresh-win)
             (hiwin-refresh-win)
             )
    (progn (hiwin-delete-ol)
           (remove-hook 'pre-command-hook  'hiwin-refresh-win)
           (remove-hook 'post-command-hook 'hiwin-refresh-win)
           (remove-hook 'window-configuration-change-hook 'hiwin-refresh-win)
           )))

(defadvice split-window-vertically
  (around hiwin-split-window-vertically activate)
  ad-do-it
  (if hiwin-ol (hiwin-draw-ol)))

(defadvice split-window-horizontally
  (around hiwin-split-window-horizontally activate)
  ad-do-it
  (if hiwin-ol (hiwin-draw-ol)))

(defadvice delete-window
  (around hiwin-delete-window activate)
  ad-do-it
  (when hiwin-ol (hiwin) (hiwin)))

(defadvice other-window
  (around hiwin-other-window activate)
  ad-do-it
  (if hiwin-ol (hiwin-draw-ol)))

(defadvice twittering-edit-close
  (around hiwin-twittering-edit-close activate)
  ad-do-it
  (when hiwin-ol (hiwin)(hiwin)))

(provide 'hiwin)
