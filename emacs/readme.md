
# Emacs trickery and setup. Assume emacs 30+

## Setup init.el to add your custom to default init file:

Run:
	C-h v user-init-file

Edit: (~/.emacs on my system)

Add the following to the top:
```
	;;; -*- lexical-binding: t; -*-
	(load-file "/home/ola/Documents/dev/tools/emacs/init.el")
```
Lexical binding is supposed to make everything emacs faster..

## Install needed packages automatically when needed

```
(unless package-archive-contents
(package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                       ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                       ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)
```


## Theme

Sample useful themes:
[emacsthemes.com](https://emacsthemes.com/popular)

https://github.com/catppuccin/emacs

https://github.com/bbatsov/solarized-emacs

```
(use-package catppuccin-theme
  :ensure t)
(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'mocha
(catppuccin-reload)
```

## treemacs

Tree layout file explorer for Emacs. I bind it to F9 key..

[treemacs](https://github.com/Alexander-Miller/treemacs)
```
(use-package treemacs
  :init
  (treemacs-project-follow-mode)
  (treemacs-follow-mode)
  ;;(treemacs-)
  :ensure t
  :bind
  ("<f9>" . treemacs))


;; Nerd icons for treemacs
(use-package treemacs-nerd-icons
  :ensure t
  :config
  (treemacs-load-theme "nerd-icons"))

;; Projectile integration for treemacs
(use-package treemacs-projectile
  :ensure t)
```

## tree-sitter

https://tree-sitter.github.io/tree-sitter/using-parsers/1-getting-started.html

Install with your package manager..

	pacman -Syu tree-sitter

TBD



### Other keybindings (sample)

* Undo key...
```
;; Use \C z as undo keys to avoid brainfucks
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z") 'undo)
```

* Meta keys
```
(global-set-key "\M- " 'set-mark-command)
(global-set-key "\M-\C-r" 'query-replace)
(global-set-key "\M-r" 'replace-string)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-h" 'help-command)
```
* dired
```
(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))
(setq dired-omit-files-p t)
```
* Function keys
```
(global-set-key [f1] 'dired)
(global-set-key [f2] 'dired-omit-toggle)
(global-set-key [f3] 'shell)
(global-set-key [f4] 'find-file)
(global-set-key [f5] 'compile)
(global-set-key [f6] 'visit-tags-table)
;(global-set-key [f7] 'folding-mode)
(global-set-key [f8] 'add-change-log-entry-other-window)
;;(global-set-key [f9] 'speedbar)
;(global-set-key [f12] 'make-frame)
```

* Control keys
```
;; Keypad bindings
(global-set-key [up] "\C-p")
(global-set-key [down] "\C-n")
(global-set-key [left] "\C-b")
(global-set-key [right] "\C-f")
(global-set-key [home] "\C-a")
(global-set-key [end] "\C-e")
(global-set-key [prior] "\M-v")
(global-set-key [next] "\C-v")
(global-set-key [C-up] "\M-\C-b")
(global-set-key [C-down] "\M-\C-f")
(global-set-key [C-left] "\M-b")
(global-set-key [C-right] "\M-f")
(global-set-key [C-home] "\M-<")
(global-set-key [C-end] "\M->")
(global-set-key [C-prior] "\M-<")
(global-set-key [C-next] "\M->")
```

*  Mouse
```
(global-set-key [mouse-3] 'imenu)
```


## Org mode

Major mode for keeping notes, authoring documents, computational notebooks, literate programming, maintaining to-do lists, planning projects, and more — in a fast and effective plain text system.

```
(use-package org
  :config
  (setq org-confirm-babel-evaluate nil)
  (setq org-html-validation-link nil)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((org        . t)
     (python     . t)
     (perl       . t)
     (C          . t)
     (lisp       . t)
     (scheme     . t)
     (shell      . t)
     (emacs-lisp . t)
     (js         . t))))


(use-package org-modern
  :hook
  (org-mode . org-modern-mode))

```

## C/C++

```
(defun my-c/c++-mode-hook ()
  "C/C++ mode hook."
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0)
  (eglot-ensure))

(add-hook 'c-mode-hook 'my-c/c++-mode-hook)
(add-hook 'c++-mode-hook 'my-c/c++-mode-hook)
```

## Python

```
TBD
```


## Company

In buffer completion framework, also enable electric pair and rainbow delimiters.

```
(use-package company
  :ensure t
  :init
  (global-company-mode)
  (electric-pair-mode)
  (rainbow-delimiters-mode)
  )


(setq company-idle-delay 0
      company-minimum-prefix-length 2)

```


## Markdown

Install [pandoc](https://pandoc.org/)


```
(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))
```
Then add to your config:

	(setq markdown-command "/usr/bin/pandoc")



## Git
I only managed to install magit manually..TODO figure out why
Magit is a text-based user interface to Git.

[melpa install](https://docs.magit.vc/magit/Installing-from-Melpa.html)


[Youtube](https://www.youtube.com/watch?v=X_iX5US1_xE "https://www.youtube.com/watch?v=X_iX5US1_xE")

```
	M-x package-install RET magit RET

	(use-package magit
	  :ensure t)
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


## Claude code

See page below for reference. Setup on emacs 30 was painless.

[claude-code-ide](https://github.com/manzaltu/claude-code-ide.el)

```
(use-package claude-code-ide
  :straight (:type git :host github :repo "manzaltu/claude-code-ide.el")
  :bind ("C-c C-'" . claude-code-ide-menu) ; Set your favorite keybinding
  :config
  (claude-code-ide-emacs-tools-setup)) ; Optionally enable Emacs MCP tools

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
