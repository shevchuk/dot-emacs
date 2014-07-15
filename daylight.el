;;; daylight.el -- Actively change themes based on the time of day

;; Copyright (C) 2013 Daniel Friedman

;; Author: Daniel Friedman
;; URL: https://github.com/daf-/emacs-daylight
;; Keywords: theming, convenience
;; Version: 0.1

;; This file is NOT part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:
;;
;; This package allows you to automate your theme switching based on
;; the current time of day.  Some themes are easier to look at in the
;; morning, and some are more appropriate later at night.
;;
;;; Code:

;;; Customization
(defcustom daylight-morning-theme nil
  "Theme chosen by daylight for the morning."
  :group 'daylight
  :type 'symbol)

(defcustom daylight-afternoon-theme nil
  "Theme chosen by daylight for the afternoon."
  :group 'daylight
  :type 'symbol)

(defcustom daylight-evening-theme nil
  "Theme chosen by daylight for the evening."
  :group 'daylight
  :type 'symbol)

(defcustom daylight-late-theme nil
  "Theme chosen by daylight for the late-night."
  :group 'daylight
  :type 'symbol)

(defcustom daylight-morning-hour 6
  "Hour at which daylight begins to apply the morning theme."
  :group 'daylight
  :type 'integer)
(defcustom daylight-afternoon-hour 12
  "Hour at which daylight begins to apply the afternoon theme."
  :group 'daylight
  :type 'integer)
(defcustom daylight-evening-hour 18
  "Hour at which daylight begins to apply the evening theme."
  :group 'daylight
  :type 'integer)

(defcustom daylight-late-hour 22
  "Hour at which daylight begins to apply the late-night theme."
  :group 'daylight
  :type 'integer)

(defcustom daylight-interval 60
  "Interval in seconds that daylight re-applies the appropriate theme."
  :group 'daylight
  :type 'integer)

(defvar daylight-timer nil
  "Timer used by daylight to change the active theme.")

(defvar daylight-last-theme nil
  "The last theme applied by daylight.")


;;; Helper functions
(defun daylight-current-hour ()
  "Return the current hour of the day as an integer."
  (string-to-number (car (split-string (cadddr (split-string (current-time-string))) ":"))))

(defun daylight-get-theme (hour)
  "Return the daylight theme for HOUR."
  (cond ((and (>= hour daylight-morning-hour) (< hour daylight-afternoon-hour))
         daylight-morning-theme)
        ((and (>= hour daylight-afternoon-hour) (< hour daylight-evening-hour))
         daylight-afternoon-theme)
        ((and (>= hour daylight-evening-hour) (< hour daylight-late-hour))
         daylight-evening-theme)
        (t
         daylight-late-theme)))

(defun daylight-choose-theme ()
  "Choose a theme based on the current time."
  (let ((theme (daylight-get-theme (daylight-current-hour))))
    (unless (equal theme daylight-last-theme)
      (mapc 'disable-theme custom-enabled-themes)
      (load-theme theme)
      (setq daylight-last-theme theme))))

(defun daylight-start ()
  "Continually change the theme based on the time of day."
  (setq daylight-timer
        (run-at-time "0 sec" daylight-interval (lambda () (daylight-choose-theme)))))

(defun daylight-stop ()
  "Stop changing themes."
  (cancel-timer daylight-timer))

;;; Minor-mode

;;;###autoload
(define-minor-mode daylight-mode
  "Minor mode to theme Emacs according to the time of day.

When called interactively, toggle `daylight-mode'.  With prefix
ARG, enable `daylight-mode' if ARG is positive, otherwise disable
it.

When called from Lisp, enable `daylight-mode' if ARG is omitted,
nil or positive.  If ARG is `toggle', toggle `projectile-mode'.
Otherwise behave as if called interactively."
  :lighter nil
  :keymap nil
  :group 'daylight
  :global t
  :require 'daylight
  (if daylight-mode
      (daylight-start)
    (daylight-stop)))

(provide 'daylight)

;;; daylight.el ends here

