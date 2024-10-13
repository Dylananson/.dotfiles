(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("9d274a57c3fa7ce2ca313c8e06887ed009d855a94addd072e95f02f56250f2d2" default))
 '(package-selected-packages '(gruvbox-theme gruber-darker-theme evil)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(load-theme 'gruvbox)
(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)

(require 'package)
(setq tool-bar-mode -1)
(setq package-archive-priorities '(("gnu" . 10)
                                   ("melpa" . 5))
      package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://stable.melpa.org/packages/")
                         ("melpa-devel" . "https://melpa.org/packages/")))
