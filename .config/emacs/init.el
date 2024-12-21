;;; init.el --- My Emacs Configuration

;;; Commentary:
;; This is my personal Emacs configuration file.

;;; Code:
;; Disable Startup Message
(setq inhibit-startup-message t)

;; Configure Backups
(setq backup-directory-alist '(("." . "~/.config/emacs/saves")))

;; Custom File
(setq custom-file "~/.config/emacs/emacs-custom.el")
(load-file custom-file)

;; UI Tweaks
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode)
(display-time-mode)

;; Editing Enhancements
(delete-selection-mode)

;; Line Numbers
(global-display-line-numbers-mode)
(setq display-line-numbers-type 'relative)

;; Initialize Packages
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(unless package-archive-contents (package-refresh-contents))
(setq use-package-always-ensure t)
(require 'use-package)

;; Font and Appearance
(set-face-attribute 'default nil :font "Space Mono Nerd Font" :height 150)
(use-package catppuccin-theme
  :init (load-theme 'catppuccin :no-confirm))

;; Modeline
(use-package doom-modeline
  :init (doom-modeline-mode))

;; Multiple Cursors
(use-package multiple-cursors)
(global-set-key (kbd "C-c e") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; Helm
(use-package helm
  :config (helm-mode))

;; Ido & Smex
(ido-mode)
(use-package smex)
(global-set-key (kbd "M-x") 'smex)

;; Which Key
(use-package which-key
  :init (which-key-mode)
  :config (setq which-key-idle-delay 0.5))

;; Tree Sitter
(use-package tree-sitter
  :hook ((prog-mode . tree-sitter-mode)
         (tree-sitter-after-on . tree-sitter-hl-mode)))
(use-package tree-sitter-langs)

;; Flycheck
(use-package flycheck
  :config (global-flycheck-mode))

;; Rainbow Delimiters
(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

;; Magit
(use-package magit
  :commands magit-status
  :bind ("C-x g" . magit-status))

;; Git Signs
(use-package diff-hl
  :hook ((prog-mode . diff-hl-mode)
	 (prog-mode . diff-hl-flydiff-mode)
         (magit-post-refresh . diff-hl-magit-post-refresh)))

;; Completion
(use-package company
  :config (global-company-mode)
  :custom ((company-minimum-prefix-length 1)
	   (company-idle-delay 0)))
(global-set-key (kbd "C-c c") 'company-complete)

;; LSP
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :init (setq lsp-keymap-prefix "C-c l")
  :hook (lsp-mode . lsp-enable-which-key-integration))

;; Just Kill the Process
(setq confirm-kill-processes nil)

;; Dart
(use-package dart-mode
  :hook (dart-mode . lsp-deferred)
  :custom (dart-format-on-save t))
(use-package hover)

;; Snippets
(use-package yasnippet
  :config (yas-global-mode))
(use-package yasnippet-snippets)

(provide 'init)
;;; init.el ends here