(tool-bar-mode 0)
(menu-bar-mode  1)
(scroll-bar-mode 0)
(global-display-line-numbers-mode 1)
(setq inhibit-startup-message t)
(setq inhibit-splash-screen t)

;; Setup window
(setq frame-title-format
      '("%b@" (:eval (or (file-remote-p default-directory 'host) system-name)) " — Emacs"))

;;; Packages

(require 'package)
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("nongnu" . "https://elpa.nongnu.org/nongnu/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))
(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t)

(use-package treemacs
  :ensure t
  :config
  (treemacs-project-follow-mode)
  (treemacs-follow-mode)
  (treemacs-filewatch-mode))

;; Projectile integration for treemacs
(use-package treemacs-projectile
  :ensure t)

(use-package yasnippet
  :ensure t
  :init
  (yas-global-mode 1)
  :config
  (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))

;;https://github.com/Cranot/claude-code-guide

(use-package claude-code
  :ensure t
  :vc ( :url "https://github.com/stevemolitor/claude-code.el" :rev :newest )
  :bind-keymap ("C-c c" . claude-code-command-map))

(use-package monet
  :ensure t
  :vc ( :url "https://github.com/stevemolitor/monet" :rev :newest ))

;(use-package eat
;  :ensure t)
(add-to-list 'exec-path "/home/ola/.local/bin/")
(setenv "PATH" (concat "/home/ola/.local/bin:" (getenv "PATH")))
;(use-package vterm
;  :ensure t)
;(setq claude-code-terminal-backend 'vterm)
;(setq claude-code-terminal-backend 'eat)
;(setq cli2eli-terminal-backend 'auto)
;;(setq cli2eli-terminal-backend 'eat)
;;(setq cli2eli-terminal-backend 'term)

;https://github.com/manzaltu/claude-code-ide.el

(use-package claude-code-ide
  :vc (:url "https://github.com/manzaltu/claude-code-ide.el" :rev :newest)
  :bind ("C-c C-'" . claude-code-ide-menu)
  :config
  (claude-code-ide-emacs-tools-setup))

;; catppuccin-theme

;; (use-package catppuccin-theme
;;   :ensure t)
;; (load-theme 'catppuccin :no-confirm)
;; (setq catppuccin-flavor 'mocha)
;; (catppuccin-reload)

(use-package zenburn-theme
  :config
  (load-theme 'zenburn t))

;; Use C-z as undo
(global-unset-key (kbd "C-z"))
(global-set-key (kbd "C-z") 'undo)

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
(global-set-key [f2] 'dired-omit-mode)
(global-set-key [f3] 'shell)
(global-set-key [f4] 'find-file)
(global-set-key [f5] 'cmake-compile-with-preset)
(global-set-key [S-f5] 'cmake-build-with-preset)
(global-set-key [f6] 'conan-install)
(global-set-key [f7] 'xref-find-references)  ; Find all instances of symbol at point
(global-set-key [f8] 'add-change-log-entry-other-window)
(global-set-key [f9] 'treemacs)

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

;; Don't add the ~ backup files
(setq make-backup-files nil)


;; UI settings
(setq display-time-format "%Y-%m-%dT%H:%M")
(setq display-time-default-load-average nil)
(display-time)
(line-number-mode 1)
(column-number-mode 1)
(show-paren-mode 1)
(setq show-paren-style 'expression)
(setq show-trailing-whitespace t)

;; This makes Emacs automatically reload files when they change on disk.


(global-auto-revert-mode 1)
(setq auto-revert-interval 1)

;; If you only  want it for specific modes or want it silent:
;; (setq auto-revert-verbose nil)

;; which-key for keybinding discovery
(use-package which-key
  :ensure t
  :init (which-key-mode))

;; Multiple cursors
(use-package multiple-cursors
  :ensure t
  :bind (("C-S-c C-S-c" . mc/edit-lines)
         ("C->" . mc/mark-next-like-this)
         ("C-<" . mc/mark-previous-like-this)
         ("C-c C-<" . mc/mark-all-like-this)
         ;; CLion-like: press C-c m, then use arrow keys to add cursors on adjacent lines
         ("C-c m" . set-rectangular-region-anchor)))

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


;;;; Programming

;;; Git
(use-package magit
  :ensure t)

;; Projectile
(use-package projectile
  :ensure t
  :init (projectile-mode +1)
  :bind-keymap ("C-c p" . projectile-command-map)
  :config
  (setq projectile-project-search-path '("~/Documents/dev/")))

;; Company mode
(use-package company
  :ensure t
  :init
  (global-company-mode)
  (electric-pair-mode))

(setq company-idle-delay 0
      company-minimum-prefix-length 2)


;;; C/C++

;; Eglot with clangd
(use-package eglot
  :ensure t
  :config
  (add-to-list 'eglot-server-programs
               '((c++-mode c++-ts-mode c-mode c-ts-mode) . ("clangd"
                  "--background-index"
                  "--clang-tidy"
                  "--completion-style=detailed"
                  "--header-insertion=iwyu"))))

;; C/C++ mode hook
(defun my-c/c++-mode-hook ()
  "C/C++ mode hook."
  (setq c-basic-offset 4)
  (c-set-offset 'substatement-open 0)
  (eglot-ensure))

(add-hook 'c-mode-hook #'my-c/c++-mode-hook)
(add-hook 'c++-mode-hook #'my-c/c++-mode-hook)

;; Tree-sitter support (Emacs 29+)
(when (and (fboundp 'treesit-available-p) (treesit-available-p))
  (add-to-list 'major-mode-remap-alist '(c-mode . c-ts-mode))
  (add-to-list 'major-mode-remap-alist '(c++-mode . c++-ts-mode))
  (setq c-ts-mode-indent-offset 4)
  (add-hook 'c-ts-mode-hook #'eglot-ensure)
  (add-hook 'c++-ts-mode-hook #'eglot-ensure))

;; Treat .h files as C++
(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

;; clang-format
(use-package clang-format
  :ensure t
  :bind (:map c++-mode-map
              ("C-c f" . clang-format-buffer)
         :map c-mode-map
              ("C-c f" . clang-format-buffer)))

;; ANSI colors in compilation buffer
(require 'ansi-color)
(add-hook 'compilation-filter-hook 'ansi-color-compilation-filter)

;; CMake
(use-package cmake-mode
  :ensure t)

(defun conan-install ()
  "Run conan install for the current project."
  (interactive)
  (let ((default-directory (or (projectile-project-root) default-directory)))
    (compile "conan install . --build=missing -of=build")))

(defun cmake--read-presets-from-file (file)
  "Read configure preset names from FILE, following any includes."
  (let ((names '()))
    (when (file-exists-p file)
      (let* ((dir (file-name-directory file))
             (json (json-read-file file))
             (includes (cdr (assoc 'include json)))
             (configure (cdr (assoc 'configurePresets json))))
        ;; Recurse into included files
        (dolist (inc (append includes nil))
          (let ((inc-file (expand-file-name inc dir)))
            (dolist (name (cmake--read-presets-from-file inc-file))
              (unless (member name names)
                (push name names)))))
        ;; Collect presets from this file
        (dolist (preset (append configure nil))
          (let ((name (cdr (assoc 'name preset))))
            (when (and name (not (member name names)))
              (push name names))))))
    (nreverse names)))

(defun cmake--read-presets ()
  "Read available CMake presets, following includes."
  (let* ((root (or (projectile-project-root) default-directory))
         (names '()))
    (dolist (file (list (expand-file-name "CMakeUserPresets.json" root)
                        (expand-file-name "CMakePresets.json" root)))
      (dolist (name (cmake--read-presets-from-file file))
        (unless (member name names)
          (push name names))))
    (nreverse names)))

(defun cmake-compile-with-preset ()
  "Configure and build a CMake project, prompting for a preset."
  (interactive)
  (let* ((default-directory (or (projectile-project-root) default-directory))
         (presets (cmake--read-presets))
         (preset (if presets
                     (completing-read "CMake preset: " presets nil nil)
                   (read-string "CMake preset: ")))
         (cmd (format "cmake --preset %s && cmake --build --preset %s"
                      (shell-quote-argument preset)
                      (shell-quote-argument preset))))
    (compile cmd)))

(defun cmake-build-with-preset ()
  "Build a CMake project, prompting for a preset (skip configure)."
  (interactive)
  (let* ((default-directory (or (projectile-project-root) default-directory))
         (presets (cmake--read-presets))
         (preset (if presets
                     (completing-read "CMake build preset: " presets nil nil)
                   (read-string "CMake build preset: ")))
         (cmd (format "cmake --build --preset %s"
                      (shell-quote-argument preset))))
    (compile cmd)))

;; Python
(setq python-shell-interpreter "/usr/bin/python3")

;; Treat 'y' or <CR> as yes, 'n' as no.
(fset 'yes-or-no-p 'y-or-n-p)
(define-key query-replace-map [return] 'act)
(define-key query-replace-map [?\C-m] 'act)

;; Misc
(transient-mark-mode 1)
(setq mark-even-if-inactive t)
(setq visible-bell nil)
(setq next-line-add-newlines nil)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(setq suggest-key-bindings nil)
(put 'eval-expression 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'set-goal-column 'disabled nil)

;; All done
(message "All done, %s@%s %s" (user-login-name) (system-name) ".")
