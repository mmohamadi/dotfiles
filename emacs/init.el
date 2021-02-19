;; Mohammad Mohammadi's emacs configuration.
(setq user-full-name "Mohammad Mohammadi"
      user-mail-address "Mohammadi.Mohammad.1996@gmail.com")

(require 'package)

;; Add melpa to package archives.
(add-to-list 'package-archives
             '("melpa" . "https://www.mirrorservice.org/sites/melpa.org/packages/") t)

(package-initialize)

(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

(setq-default use-package-verbose t)

;; use y-n instead of yes-no
(defalias 'yes-or-no-p 'y-or-n-p)

;; tab setting
(setq indent-tabs-mode nil
      tab-width 4) 

;; Be quiet, please
(setq ring-bell-function 'ignore)

(setq-default fill-column 80)

;; custom file settings
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; dispaly column number
(column-number-mode +1)

;; display line numbers
(global-display-line-numbers-mode +1)

;; highlight matching paranthesis
(use-package paren 
  :config
  (show-paren-mode 1)
  (setq show-paren-delay 0))


;;; appearence settings

;; set font size
(set-face-attribute 'default nil :height 105)


;; maximize the frame
(add-to-list 'default-frame-alist '(fullscreen . maximized))

;; disable unneseccary X bars 
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
;; highlight the current line
(global-hl-line-mode) 

;; disable startup message
(setq inhibit-startup-message t)

;; scroll settings
(setq mouse-wheel-scroll-amount '(1
                                  ((shift) . 5)))

;; directory tree package
(use-package neotree
  :ensure t
  :defer t
  :bind
  ("C-c t" . neotree-toggle))

(use-package all-the-icons
  :ensure t
  :defer t)

;; theme settings
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-dark+ t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)
  
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;; cursor settings
(setq-default cursor-type 'bar)


;; ivy related packages
(use-package ivy
  :ensure t
  :bind
  (:map ivy-minibuffer-map
        ("RET" . 'ivy-alt-done))
  :config
  (setq ivy-height 10)
  (setq ivy-wrap t)
  (ivy-mode +1))

(use-package counsel
  :ensure t
  :bind
  ("C-h a" . counsel-apropos))

(use-package swiper
  :ensure t
  :after ivy
  :bind
  ("C-s" . swiper))

;; auto-completion
(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0)
  (setq company-minimum-prefix-length 2)
  (setq company-show-numbers t)
  :hook
  (prog-mode . company-mode)
    :bind (:map company-active-map
              ("C-n" . company-select-next)
              ("C-p" . company-select-previous)
              ("C-o" . company-other-backend)
              ("<tab>" . company-complete-common-or-cycle)
              ("RET" . company-complete-selection)))

;; set-up modeline
(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1))

;; setup ripgrep front-end
(use-package rg
  :ensure t
  :config
  (rg-enable-default-bindings))



;; set-up lsp
(setq lsp-keymap-prefix "s-l")

(use-package lsp-mode
  :ensure t
  :init
  (setq lsp-auto-guess-root t)
  :hook ( 
         (prog-mode . lsp-deferred)
;;         (before-save . lsp-format-buffer)
         (lsp-mode . lsp-enable-which-key-integration))
  :commands (lsp lsp-deferred))
(use-package lsp-ivy :commands lsp-ivy-workspace-symbol)


;; set-up golang mode
;; currently using gopls as go language server
(use-package go-mode
  :defer t
  :ensure t
  :after (lsp-mode)
  :bind
  ("C-c c" . comment-or-uncomment-region)
  :config
  (yas-reload-all)
  (add-hook 'go-mode-hook #'yas-minor-mode)
  (when (featurep 'lsp-mode)
    (add-hook 'before-save-hook (lambda ()
                                  (lsp-format-buffer)
                                  (lsp-organize-imports)))))

;; set-up dockerfile mode
;; currently using
;; https://github.com/rcjsuen/dockerfile-language-server-nodejs
;; as dockerfile language server
(use-package dockerfile-mode
  :ensure t
  :init
  (add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode)))

;; set-up yaml mode
(use-package yaml-mode
  :ensure t)

;; templates for programming constructs
(use-package yasnippet
  :ensure t
  :hook (prog-mode . (lambda ()
                       (yas-reload-all)
                       (yas-minor-mode)))
) 

;; set-up protobuf mode
(use-package protobuf-mode
  :ensure t)

;; install official snippets
(use-package yasnippet-snippets
  :ensure t
  :defer t
)

;; set-up which-key
(use-package which-key
  :ensure t
  :config
  (which-key-mode)
  (which-key-setup-side-window-right)
)

;; auto-pair set-up
(use-package smartparens
  :ensure t
  :hook
  (prog-mode . smartparens-mode))


;; set-up writeroom
(use-package writeroom-mode
  :ensure
  :bind
  ("C-c w" . writeroom-mode))
