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
  "Assure every package is installed, ask for installation if it’s not.

   Return a list of installed packages or nil for every skipped package."
  (mapcar
    (lambda (package)
      (if (package-installed-p package)
        nil
        (if (y-or-n-p (format "Package %s is missing. Install it? " package))
          (package-install package)
          package)))
    packages))

;; Make sure to have downloaded archive description.
(or (file-exists-p package-user-dir)
    (package-refresh-contents))

(ensure-package-installed 'evil
                          'evil-surround
                          'helm
                          'key-chord
                          'rainbow-delimiters
                          'smart-mode-line
                          'cider
                          'multi-term
                          'ace-window
                          'slime
                          'tuareg
                          'magit
                          )

(add-to-list 'default-frame-alist '(font . "DejaVu Sans Mono-11"))
(set-face-attribute 'default t :font "DejaVu Sans Mono-11")

;; Cleanup whitespace on every save
(add-hook 'before-save-hook 'whitespace-cleanup)

(require 'multi-term)
(setq multi-term-program "/bin/bash")

(require 'ace-window)
(global-set-key (kbd "M-p") 'ace-window)

(require 'cider)
(setq cider-show-error-buffer nil)

;; (require 'helm)
;; (global-set-key (kbd "M-x") 'helm-M-x)
;; (setq helm-mode-fuzzy-match t)
;; (setq helm-completions-in-region-fuzzy-match t)

;; Don't let ido mess up dir/file making!
(setq ido-auto-merge-work-directories-length -1)

;; Slime REPL
(setq inferior-lisp-program (executable-find "sbcl"))

;; Prevent line wraps
(set-default 'truncate-lines t)

;; Allow easy window switching with shift-<dir>
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;; Get rid of that ugly welcome message.
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Highlight matching parens
(show-paren-mode t)

;; Only spaces
(setq-default indent-tabs-mode nil)

;; Remove nuisances
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Change the size
;(add-to-list 'default-frame-alist '(height . 60))
;(add-to-list 'default-frame-alist '(width . 120))

;; Make linum-mode a keyboard toggle
(global-set-key (kbd "C-M-l") 'linum-mode)
(column-number-mode t)


(require 'evil)
(evil-mode t)

(require 'evil-surround)
(evil-surround-mode t)

;; Easily resize windows in a frame.
;; Acts weirdly in different windows
(global-set-key (kbd "S-C-<left>") 'shrink-window-horizontally)
(global-set-key (kbd "S-C-<right>") 'enlarge-window-horizontally)
(global-set-key (kbd "S-C-<down>") 'shrink-window)
(global-set-key (kbd "S-C-<up>") 'enlarge-window)

;; Forcefully remove evil-mode (basically) from term states
;; One can use `ctl-z` to toggle evil-mode back on
;(delete 'term-mode evil-insert-state-modes)
;(add-to-list 'evil-emacs-state-modes 'term-mode)

(require 'rainbow-delimiters)
(rainbow-delimiters-mode t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode t)

;; Not sure about helm mode just yet...
;(require 'helm)
;;(helm-mode t)

;; Reset escape key
(require 'key-chord)
(key-chord-mode t)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (gruvbox)))
 '(custom-safe-themes
   (quote
    ("bcc6775934c9adf5f3bd1f428326ce0dcd34d743a92df48c128e6438b815b44f" "b6db49cec08652adf1ff2341ce32c7303be313b0de38c621676122f255ee46db" "03e3e79fb2b344e41a7df897818b7969ca51a15a67dc0c30ebbdeb9ea2cd4492" "cdfb22711f64d0e665f40b2607879fcf2607764b2b70d672ddaa26d2da13049f" "8e3f020f1ce69cfa0c1ebee4e198feb28dd7eb31b7d77927e9c790819210c654" "df3e05e16180d77732ceab47a43f2fcdb099714c1c47e91e8089d2fcf5882ea3" "0b6645497e51d80eda1d337d6cabe31814d6c381e69491931a688836c16137ed" "f245c9f24b609b00441a6a336bcc556fe38a6b24bfc0ca4aedd4fe23d858ba31" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "79a3f477ac0cb4a106f78b6109614e991564a5c2467c36e6e854d4bc1102e178" "badc4f9ae3ee82a5ca711f3fd48c3f49ebe20e6303bba1912d4e2d19dd60ec98" "b959f70a09f7ae16812bfc5bec2fd6b21081bee1f68686cdd80b3045bfc27b21" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "9e720b0c4ed90ce3735c94705f93b519191f5220e73dbacf6a4d71b89a0a6b0e" default)))
 '(fci-rule-color "#383838")
 '(nrepl-message-colors
   (quote
    ("#CC9393" "#DFAF8F" "#F0DFAF" "#7F9F7F" "#BFEBBF" "#93E0E3" "#94BFF3" "#DC8CC3")))
 '(vc-annotate-background "#2B2B2B")
 '(vc-annotate-color-map
   (quote
    ((20 . "#BC8383")
     (40 . "#CC9393")
     (60 . "#DFAF8F")
     (80 . "#D0BF8F")
     (100 . "#E0CF9F")
     (120 . "#F0DFAF")
     (140 . "#5F7F5F")
     (160 . "#7F9F7F")
     (180 . "#8FB28F")
     (200 . "#9FC59F")
     (220 . "#AFD8AF")
     (240 . "#BFEBBF")
     (260 . "#93E0E3")
     (280 . "#6CA0A3")
     (300 . "#7CB8BB")
     (320 . "#8CD0D3")
     (340 . "#94BFF3")
     (360 . "#DC8CC3"))))
 '(vc-annotate-very-old-color "#DC8CC3"))

;; Set up smart mode line
;; This needs to be after custom-vars
(setq sml/theme 'respectful)
(sml/setup)
