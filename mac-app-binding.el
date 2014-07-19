;;; mac-app-binding.el Emacs bindings for Mac OS X apps

;; Copyright (c) 2011 Tobias Svensson <tob@tobiassvensson.co.uk>

;; Author: Lkhagva Ochirkhuyag <ochkoo@gmail.com>
;; URL: https://github.com/ochko/mac-app-binding.el
;; Keywords: mac applescript
;; Created: 24 Dec 2013
;; Version: 1.0.0
;; Package-Requires: ((org))

;; This file is NOT part of GNU Emacs.

;;; Commentary:

;; Taken from org-mac-message.el written by John Wiegley <johnw@gnu.org>
;; Emacs bindings for Mac OS X apps.
;;
;; 1) mac-run-applescript
;;
;;    Run applescript text source.
;;    Requires `osascript` program in PATH
;;
;; 2) mac-open
;;
;;    Opens current buffer's file with Mac's `open` command.
;;
;; 3) mac-open-with-textedit
;;
;;    Open current buffer's file with Mac's TextEdit.app.

;;; Install

;; $ cd ~/.emacs.d/vendor
;; $ git clone git://github.com/ochko/mac-app-binding.el
;;
;; In your emacs config:
;;
;; (add-to-list 'load-path "~/.emacs.d/vendor/mac-app-binding.el")
;; (require 'mac-app-binding)

;;; Code:
(require 'org)

(defun mac-run-applescript (script)
  (let (start cmd return)
    (while (string-match "\n" script)
      (setq script (replace-match "\r" t t script)))
    (while (string-match "'" script start)
      (setq start (+ 2 (match-beginning 0))
            script (replace-match "\\'" t t script)))
    (setq cmd (concat "osascript -e '" script "'"))
    (setq return (shell-command-to-string cmd))
    (concat "\"" (org-trim return) "\"")))

(defun mac-open-path-with-textedit (path)
  (mac-run-applescript (concat "tell application \"TextEdit\"
    open \"" path "\""
    "activate
end tell")))

(defun mac-open-with-textedit()
  (interactive)
  (if (stringp buffer-file-name)
      (mac-open-path-with-textedit (file-truename buffer-file-name))
    (message "Please save the buffer to open in TextEdit")))

(defun mac-open()
  (interactive)
  (if (stringp buffer-file-name)
      (shell-command-to-string (concat "open " (file-truename buffer-file-name)))
    (message "Please save the buffer to open it in external program")))


(provide 'mac-app-binding)
