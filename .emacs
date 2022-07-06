(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)

(setq package-selected-packages '(lsp-mode yasnippet lsp-treemacs helm-lsp
    projectile hydra flycheck company avy which-key helm-xref dap-mode company-c-headers))

(when (cl-find-if-not #'package-installed-p package-selected-packages)
  (package-refresh-contents)
  (mapc #'package-install package-selected-packages))

(setq default-directory "/home/b1nc0d3x/.emacs.d/") 

;; sample `helm' configuration use https://github.com/emacs-helm/helm/ for details

(when window-system (set-frame-size (selected-frame) 160 48))

(add-to-list 'default-frame-alist '(height . 48))
    (add-to-list 'default-frame-alist '(width . 160))

(ac-config-default)

(helm-mode)
(require 'helm-xref)
(define-key global-map [remap find-file] #'helm-find-files)
(define-key global-map [remap execute-extended-command] #'helm-M-x)
(define-key global-map [remap switch-to-buffer] #'helm-mini)

(which-key-mode)
(add-hook 'c-mode-hook 'lsp)
(add-hook 'c++-mode-hook 'lsp)


(setq gc-cons-threshold (* 100 1024 1024)
      read-process-output-max (* 1024 1024)
      treemacs-space-between-root-nodes nil
      company-idle-delay 0.0
      company-minimum-prefix-length 1      
      lsp-idle-delay 0.1)  ;; clangd is fast


(require 'company-c-headers)
(require 'company-capf)
(require 'clang-format)

(add-to-list 'company-c-headers-path-system "/usr/local/include")
(add-to-list 'company-c-headers-path-system "/usr/src/sys")
(add-to-list 'company-c-headers-path-system "/usr/src")
(add-to-list 'company-c-headers-path-system "/usr/include/c++/v1/") 
(add-to-list 'company-c-headers-path-system "/usr/include")

(with-eval-after-load 'lsp-mode
  (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
  (require 'dap-cpptools)
  (yas-global-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(package-selected-packages
   '(elpy virtualenv company-jedi jedi clang-capf clang-format ac-clang async zenburn-theme yasnippet use-package pydoc ivy irony-eldoc flycheck company-irony-c-headers company-irony c-eldoc auto-complete-c-headers ac-c-headers)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "DejaVu Sans Mono" :foundry "PfEd" :slant normal :weight normal :height 120 :width normal)))))
;(require 'lsp-mode)

;(require 'lsp-ui)

(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)

(require 'elpy)
(setq cc-search-directories '(
			      "/usr/include/c++/v1/"
			      "/usr/include"
			      "/usr/src/sys"
			      "/usr/src"
			      "/usr/local/include"))

(electric-pair-mode 1)
