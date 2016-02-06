;;
;; .emacs, Ryan James Spencer
;;

(require 'package)
(when (>= emacs-major-version 24)
  (require 'package)
  (add-to-list
    'package-archives
    '("melpa" . "http://melpa.org/packages/")
    t)
  (package-initialize))

;; Credit to Aaron Bieber for this.
(defun ensure-package-installed (&rest packages)
  "Installs all uninstalled packages "
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (package-install package)))
   packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(defun kill-other-buffers ()
  "Kill all other buffers."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun kill-other-buffers-and-windows ()
  "Kill all buffers and windows except the currently selected."
  (interactive)
  (mapc 'kill-buffer (delq (current-buffer) (buffer-list)))
  (delete-other-windows))

(ensure-package-installed 'evil         ;; Essential
                          'evil-escape
                          'evil-magit
                          'evil-surround

                          'base16-theme ;; Aesthetic
                          'gruvbox-theme
                          'rainbow-delimiters
                          'rainbow-mode
                          'smart-mode-line

                          'ace-window   ;; Productivity
                          'bind-key
                          'company
                          'free-keys
                          'ggtags
                          'git-timemachine
                          'helm
                          'hl-todo
                          'magit
                          'multi-term

                          'cider        ;; Programming
                          'clj-refactor
                          'clojure-cheatsheet
                          'cmake-mode
                          'elixir-mode
                          'erlang
                          'go-mode
                          'haskell-mode
                          'inf-ruby
                          'markdown-preview-mode
                          'php-mode
                          'rust-mode
                          'scala-mode2
                          'slime
                          'tuareg

                          '2048-game    ;; Games
                          'chess
                          'ducpel
                          'gnugo
                          'poker
                          'sokoban
                          )

(require 'bind-key)
(bind-key "C-c 1" 'kill-other-buffers-and-windows)

(require 'hl-todo)
(hl-todo-mode t)

(require 'company)
(add-hook 'after-init-hook 'global-company-mode)

(add-hook 'cider-repl-mode-hook #'company-mode)
(add-hook 'cider-mode-hook #'company-mode)

;; Make reloading .emacs changes easier
(defun reload-emacs ()
  (interactive)
  (load-file "~/.emacs"))
(bind-key "C-x r l" 'reload-emacs)

;; Setup keybind for magit-status
(require 'magit)
(bind-key "C-c g" 'magit-status)

;; Set default font
(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-11"))
(set-face-attribute 'default t :font "DejaVu Sans Mono-11")

;; Cleanup whitespace on every save
(add-hook 'before-save-hook 'whitespace-cleanup)

;; Show the time
(display-time-mode t)

(require 'multi-term)
(setq multi-term-program "/bin/bash")
(bind-key "C-x t" 'multi-term)

;; Smoother window transitions
(require 'ace-window)
(bind-key "<C-tab>" 'ace-window)

(require 'cider)
(setq cider-show-error-buffer nil)

;; go-mode gofmt before save
(add-hook 'before-save-hook #'gofmt-before-save)

;; Don't let ido steal focus when trying to create dirs/files
(setq ido-auto-merge-work-directories-length -1)

;; Slime REPL
(setq inferior-lisp-program (executable-find "sbcl"))

;; Prevent line wrapping
(set-default 'truncate-lines t)
;; Toggle word wrapping for long lines
(bind-key "C-'" 'visual-line-mode)

;; For helpful configuration
(bind-key "C-h C-k" 'free-keys)

;; Get rid of that ugly welcome message.
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Highlight matching parens
(setq show-paren-delay 0)
(show-paren-mode t)
(setq show-paren-style 'mixed)

;; Only spaces
(setq-default indent-tabs-mode nil)

;; Remove nuisances
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Tell which column point is on
(column-number-mode t)

(require 'evil)
(evil-mode t)

;; Make evil keybindings work in git-timemachine
;; see http://blog.binchen.org/posts/use-git-timemachine-with-evil.html
(require 'git-timemachine)
(eval-after-load 'git-timemachine
  '(progn
     (evil-make-overriding-map git-timemachine-mode-map 'normal)
     (add-hook 'git-timemachine-mode-hook #'evil-normalize-keymaps)))

(require 'evil-surround)
(global-evil-surround-mode t)

(require 'evil-escape)
(evil-escape-mode t)

;; I'm not sure if this nullifies the key-chord approach
(setq-default evil-escape-key-sequence "jk")
(setq-default evil-escape-delay 0.2)

(require 'evil-magit)
(evil-define-key evil-magit-state magit-mode-map "?" 'evil-search-backward)

;; Easily resize windows in a frame.
(global-set-key (kbd "S-C-<left>")  'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>")  'shrink-window)
(global-set-key (kbd "S-C-<up>")    'enlarge-window)

(require 'rainbow-delimiters)
(rainbow-delimiters-mode t)

;; Ido niceties
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

(require 'smart-mode-line)
(setq sml/theme 'respectful)
(add-hook 'after-init-hook 'sml/setup)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (base16-ocean-dark)))
 '(custom-safe-themes
   (quote
    ("3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "b04425cc726711a6c91e8ebc20cf5a3927160681941e06bc7900a5a5bfe1a77f" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "e1551b5516e0a439b6ab019ba00cee866e735f66f22ff67a5d882ad0f1383454" "70000dc33dbd9be73686fb5c23e471137da9866ff65b36e8e43315f719495640" "50e7f9d112e821e42bd2b8410d50de966c35c7434dec12ddea99cb05dd368dd8" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" default)))
 '(safe-local-variable-values
   (quote
    ((eval when
           (fboundp
            (quote rainbow-mode))
           (rainbow-mode 1))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
