### Install

Clone this repo:

```shell
$ cd ~/.emacs.d/vendor
$ git clone git://github.com/ochko/mac-app-binding.el
```

In your emacs config:

```elisp
(add-to-list 'load-path "~/.emacs.d/vendor/mac-app-binding.el")
(require 'mac-app-binding)
```
### Usage

- mac-run-applescript

   Run applescript text source.
   Requires `osascript` program in PATH

- mac-open

   Opens current buffer's file with Mac's `open` command.

- mac-open-with-textedit

   Open current buffer's file with Mac's TextEdit.app.

