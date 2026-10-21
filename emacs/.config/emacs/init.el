;;; -*- lexical-binding: t -*-
(require 'use-package)
(use-package gptel
  :ensure t
  :config (setq gptel-model 'gpt-5.6-sol
		gptel-backend (gptel-make-openai-oauth "ChatGPT"))
g
(use-package marginalia
  :ensure t
  :init (marginalia-mode 1))
 
(use-package vertico
  :ensure t
  :init (vertico-mode 1))

(use-package magit
  :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(scroll-bar-mode nil)
 '(tool-bar-position 'bottom)
 '(tool-bar-style 'text))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
