(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("e13beeb34b932f309fb2c360a04a460821ca99fe58f69e65557d6c1b10ba18c7" "9d274a57c3fa7ce2ca313c8e06887ed009d855a94addd072e95f02f56250f2d2" default))
 '(package-selected-packages
   '(evil-collection omnisharp lsp-mode smex gruvbox-theme gruber-darker-theme evil)))


(setq evil-want-keybinding nil)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'package)
(setq tool-bar-mode -1)
(setq package-archive-priorities '(("gnu" . 10)
                                   ("melpa" . 5))
      package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
                         ("melpa" . "https://stable.melpa.org/packages/")
                         ("melpa-devel" . "https://melpa.org/packages/")))
(package-initialize)

;; Set the Command key as Meta
(setq mac-command-modifier 'meta)

;; Optionally set Option (Alt) key to be the Super key
(setq mac-option-modifier 'super)

(require 'ido)
(ido-mode t)

(setq ring-bell-funciton 'ignore)
(setq visible-bell nil)

 ;;; ido
;(require 'smex 'ido-completing-read+)
(require 'smex)

(global-set-key (kbd "M-x") 'smex)
  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
  ;; This is your old M-x.
  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

					;(require 'ido-completing-read+)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

(ido-mode 1)
(ido-everywhere 1)
;(ido-ubiquitous-mode 1)

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)
(column-number-mode 1)
(show-paren-mode 1)

(global-display-line-numbers-mode 1)
(setq display-line-numbers-type 'relative)


(load-theme 'gruber-darker)

;; Set up package.el to work with MELPA
(package-refresh-contents)

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))

;; Enable Evil
(require 'evil)
(evil-mode 1)

(setq evil-want-C-d-scroll t)

(setq evil-search-wrap t)

(evil-set-leader 'normal (kbd "SPC"))


(use-package evil
  :diminish undo-tree-mode
  :init
  (setq evil-want-C-u-scroll t
        evil-want-keybinding nil
        evil-shift-width ian/indent-width)
  :hook (after-init . evil-mode)
  :preface
  (defun ian/save-and-kill-this-buffer ()
    (interactive)
    (save-buffer)
    (kill-this-buffer))
  :config
  (with-eval-after-load 'evil-maps ; avoid conflict with company tooltip selection
    (define-key evil-insert-state-map (kbd "C-n") nil)
    (define-key evil-insert-state-map (kbd "C-p") nil))
  (evil-ex-define-cmd "q" #'kill-this-buffer)
  (evil-ex-define-cmd "wq" #'ian/save-and-kill-this-buffer))


(use-package evil-collection
  :after evil
  :config
  (setq evil-collection-company-use-tng nil)
  (evil-collection-init))

