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
                          )

;; Get rid of that ugly welcome message.
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Remove nuisances
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)

;; Change the size
;(add-to-list 'default-frame-alist '(height . 60))
;(add-to-list 'default-frame-alist '(width . 120))

;; Linenums!
(global-linum-mode t)

(require 'evil)
(evil-mode t)

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
    ("b959f70a09f7ae16812bfc5bec2fd6b21081bee1f68686cdd80b3045bfc27b21" "f5eb916f6bd4e743206913e6f28051249de8ccfd070eae47b5bde31ee813d55f" "9e720b0c4ed90ce3735c94705f93b519191f5220e73dbacf6a4d71b89a0a6b0e" default)))
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
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:background nil)))))
