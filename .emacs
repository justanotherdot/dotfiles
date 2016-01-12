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
                          'helm
                          'key-chord
                          'rainbow-delimiters
                          'smart-mode-line
                          'cider
                          'multi-term
                          'ace-window
                          )

(require 'multi-term)
(setq multi-term-program "/bin/bash")

(require 'ace-window)
(global-set-key (kbd "M-p") 'ace-window)

;; Slime REPL
(setq inferior-lisp-program (executable-find "sbcl"))

(set-default 'truncate-lines t)

;; Get rid of that ugly welcome message.
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

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

;; Linenums!
(global-linum-mode t)
(column-number-mode t)

(require 'evil)
(evil-mode t)

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

(ido-mode t)

;(require 'helm)
;;(helm-mode t)

;; Reset escape key
(require 'key-chord)
(key-chord-mode 1)
(key-chord-define evil-insert-state-map "jk" 'evil-normal-state)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (gruvbox)))
 '(custom-safe-themes
   (quote
    ("df3e05e16180d77732ceab47a43f2fcdb099714c1c47e91e8089d2fcf5882ea3" "0b6645497e51d80eda1d337d6cabe31814d6c381e69491931a688836c16137ed" "f245c9f24b609b00441a6a336bcc556fe38a6b24bfc0ca4aedd4fe23d858ba31" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "79a3f477ac0cb4a106f78b6109614e991564a5c2467c36e6e854d4bc1102e178" "badc4f9ae3ee82a5ca711f3fd48c3f49ebe20e6303bba1912d4e2d19dd60ec98" "b959f70a09f7ae16812bfc5bec2fd6b21081bee1f68686cdd80b3045bfc27b21" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "9e720b0c4ed90ce3735c94705f93b519191f5220e73dbacf6a4d71b89a0a6b0e" default)))
 '(fci-rule-color "#383838")
 '(helm-mode nil)
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))

;; Set up smart mode line
(setq sml/theme 'respectful)
(sml/setup)
