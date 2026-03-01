
#Emacs trickery and setup. Assume emacs 30+

## Setup init.el to add your custom to default init file:

Run:
	C-h v user-init-file

Edit: (~/.emacs on my system)

      (load-file "/path/to/custom/init.el")

### Add custom init on startup (Currently not working...)
    export EMACSINIT="/path/to/custom/init.el"



## Install themes

https://github.com/catppuccin/emacs

	  M-x package-install RET catpuccin-theme

https://github.com/bbatsov/solarized-emacs

	  M-x package-install RET solarized-theme


## Impatient mode

   M-x package-install RET impatient-mode RET
   M-x httpd-start
   M-x impatient-mode

```
(defun markdown-html (buffer)
    (princ (with-current-buffer buffer
      (format "<!DOCTYPE html><html><title>Impatient Markdown</title><xmp theme=\"united\" style=\"display:none;\"> %s  </xmp><script src=\"http://ndossougbe.github.io/strapdown/dist/strapdown.js\"></script></html>" (buffer-substring-no-properties (point-min) (point-max))))
    (current-buffer)))
```

## Add copilot
See https://deepwiki.com/copilot-emacs/copilot.el/1.1-installation

    M-x copilot-login
    M-x copilot-diagnose


Enabling copilot-mode

To enable copilot-mode in programming buffers, add:
```
   (add-hook 'prog-mode-hook 'copilot-mode)
```

Setting Up Key Bindings

Set up key bindings for accepting completions:

```
(define-key copilot-completion-map (kbd "<tab>") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "TAB") 'copilot-accept-completion)
(define-key copilot-completion-map (kbd "C-TAB") 'copilot-accept-completion-by-word)
(define-key copilot-completion-map (kbd "C-<tab>") 'copilot-accept-completion-by-word)
```

You can also add bindings for cycling through completions:
```
(define-key copilot-completion-map (kbd "C-n") 'copilot-next-completion)
(define-key copilot-completion-map (kbd "C-p") 'copilot-previous-completion)
```
