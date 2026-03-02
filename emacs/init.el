;;; -*- lexical-binding: t; -*-

(setq first-time nil)
(tool-bar-mode 0)
(menu-bar-mode  1)
(scroll-bar-mode 0)
(setq inhibit-startup-message 1)

;; Setup window
 (setq frame-title-format
	'("%b@" (:eval (or (file-remote-p default-directory 'host) system-name)) " — Emacs"))

(setq inhibit-splash-screen t)
(setq ingibit-startup-message t)

;;Packages

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

(use-package treemacs
  :init
  (treemacs-project-follow-mode)
  (treemacs-follow-mode)
  ;;(treemacs-)
  :ensure t
  :bind
  ("<f9>" . treemacs))



;;(use-package copilot
;;  :straight (:host github :repo "copilot-emacs/copilot.el" :files ("*.el"))
;;  :ensure t)
;;(use-package copilot
;;  :quelpa (copilot :fetcher github
;;                   :repo "copilot-emacs/copilot.el"
;;                   :branch "main"
;;:files ("*.el")))

;; Emacs 30+
;(use-package copilot
;  :vc (:url "https://github.com/copilot-emacs/copilot.el"
;            :rev :newest
;            :branch "main"))




;; catppuccin-theme

(use-package catppuccin-theme
  :ensure t)
(load-theme 'catppuccin :no-confirm)
(setq catppuccin-flavor 'mocha) ;; or 'latte, 'macchiato, or 'mocha
(catppuccin-reload)

;; solarize
;(use-package solarized-theme
;  :ensure t)
;(load-theme 'solarized-dark t)
;  (load-theme 'solarized-light t)
;; Meta keys
(global-set-key "\M- " 'set-mark-command)
(global-set-key "\M-\C-r" 'query-replace)
(global-set-key "\M-r" 'replace-string)
(global-set-key "\M-g" 'goto-line)
(global-set-key "\M-h" 'help-command)

(add-hook 'dired-load-hook (function (lambda () (load "dired-x"))))
(setq dired-omit-files-p t)

;; Function keys
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

;; Control keys
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

;; Mouse
(global-set-key [mouse-3] 'imenu)

;; Misc
(global-set-key [C-tab] "\C-q\t")   ; Control tab quotes a tab.
(setq backup-by-copying-when-mismatch t)

;;Don't  add the ~ backup files
(setq make-backup-files nil)


;; Show paren mode
;;UI settings
(display-time)
(line-number-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
(setq show-paren-style 'expression)


;; Useful tools

(use-package flyspell
  :ensure t
  :config
  (setq ispell-program-name "aspell"))

(use-package markdown-mode
  :ensure t
  :mode ("README\\.md\\'" . gfm-mode)
  :init (setq markdown-command "multimarkdown")
  :bind (:map markdown-mode-map
              ("C-c C-e" . markdown-do)))

(setq markdown-command "/usr/bin/pandoc")

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


;;;;;; Programming
;;;  Git
;; Magit
;(use-package magit
;:ensure t)


; company mode
(use-package company
  :ensure t
  :init
  (global-company-mode)
  (electric-pair-mode)
  (rainbow-delimiters-mode)
  )


(setq company-idle-delay 0
      company-minimum-prefix-length 2)


;; C++
(defun my-c/c++-mode-hook ()
  "C/C++ mode hook."
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0)
  (eglot-ensure))

(add-hook 'c-mode-hook 'my-c/c++-mode-hook)
(add-hook 'c++-mode-hook 'my-c/c++-mode-hook)

;; Python
(setq python-shell-interpreter "/usr/bin/python3")

;; Treat 'y' or <CR> as yes, 'n' as no.
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)

;; Pretty diff mode
(autoload 'ediff-buffers "ediff" "Intelligent Emacs interface to diff" t)
(autoload 'ediff-files "ediff" "Intelligent Emacs interface to diff" t)
(autoload 'ediff-files-remote "ediff"
  "Intelligent Emacs interface to diff")

(if first-time
    (setq auto-mode-alist
      (append '(("\\.cpp$" . c++-mode)
            ("\\.hpp$" . c++-mode)
            ("\\.lsp$" . lisp-mode)
            ("\\.scm$" . scheme-mode)
            ("\\.pl$" . perl-mode)
            ) auto-mode-alist)))

;; Auto font lock mode
(defvar font-lock-auto-mode-list
  (list 'c-mode 'c++-mode 'c++-c-mode 'emacs-lisp-mode 'lisp-mode 'perl-mode 'scheme-mode)
  "List of modes to always start in font-lock-mode")

(defun font-lock-auto-mode-select ()
  "Automatically select font-lock-mode if the current major mode is in font-lock-auto-mode-list"
  (if (memq major-mode font-lock-auto-mode-list)
      (progn
    (font-lock-mode t))
    )
)
(global-set-key [M-f1] 'font-lock-fontify-buffer)



;; Complement to next-error
(defun previous-error (n)
  "Visit previous compilation error message and corresponding source code."
  (interactive "p")
  (next-error (- n)))

(setq compile-command "cmake --build -S ./ -B build")



;; Misc...
(transient-mark-mode 1)
(setq mark-even-if-inactive t)
(setq visible-bell nil)
(setq next-line-add-newlines nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq suggest-key-bindings nil)
(put 'eval-expression 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)
(if (>= emacs-major-version 21)
    (setq show-trailing-whitespace t))

;; Elisp archive searching
(autoload 'format-lisp-code-directory "lispdir" nil t)
(autoload 'lisp-dir-apropos "lispdir" nil t)
(autoload 'lisp-dir-retrieve "lispdir" nil t)
(autoload 'lisp-dir-verify "lispdir" nil t)



(setq font-lock-doc-string-face 'green)
(add-hook 'find-file-hooks 'font-lock-auto-mode-select)

;; All done
(message "All done, %s@%s %s" (user-login-name) (system-name) ".")
