;;; package --- Summary
;;; Commentary:
;;; Code:

;;;;;;;;;;;;;;;;;;;;
;;; Custom Stuff ;;;
;;;;;;;;;;;;;;;;;;;;

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ahk-syntax-directory "c:/Users/Brian/Desktop/Main.ahk" t)
 '(electric-indent-mode t)
 '(electric-layout-mode nil)
 '(electric-pair-mode t)
 '(indent-tabs-mode nil)
 '(inhibit-startup-screen t)
 '(js-indent-level 2)
 '(markdown-command "/c/Users/Brian/AppData/Local/Pandoc/pandoc")
 '(package-selected-packages
   (quote
    (typescript-mode flycheck-mypy markdown-mode+ markdown-mode tuareg flycheck yasnippet web-mode multiple-cursors js2-mode auto-complete)))
 '(require-final-newline nil)
 '(typescript-indent-level 2))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq electric-pair-pairs '(
			   (?\( . ?\))
			   (?[  . ?])
			   (?{  . ?})
			   (?<  . ?>)
			   (?\" . ?\")))

(setq-default cursor-type 'bar)
(x-focus-frame nil)
(setq column-number-mode t)
(setq-default show-trailing-whitespace t)

;;;;;;;;;;;;;;;;;;;;
;;; Key Bindings ;;;
;;;;;;;;;;;;;;;;;;;;
(global-set-key (kbd "<mouse-4>") 'previous-buffer)
(global-set-key (kbd "<mouse-5>") 'next-buffer)

;;;;;;;;;;;;;;;;;;;;
;;;     Melpa    ;;;
;;;;;;;;;;;;;;;;;;;;
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.org/packages/"))
(package-initialize)
(add-hook 'after-init-hook #'global-flycheck-mode)

;;;;;;;;;;;;;;;;;;;;;
;;; Markdown Mode ;;;
;;;;;;;;;;;;;;;;;;;;;
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Multiple Cursors Mode ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elpa/multiple-cursors-20141026.503")
(require 'multiple-cursors)

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-lines-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;;;;;;;;;;;;;;;;;;;;
;;;   Autopair   ;;;
;;;;;;;;;;;;;;;;;;;;
(setq skeleton-pair-alist
      '((?\( _ ?\))
	(?[  _ ?])
	(?{  _ ?})
	(?<  _ ?>)
	(?'  _ ?')
	(?\" _ ?\")))

(defun autopairs-ret (arg)
  (interactive "P")
 (let (pair)
    (dolist (pair skeleton-pair-alist)
      (when (eq (char-after) (car (last pair)))
	(save-excursion (newline-and-indent))))
    (newline arg)
    (indent-according-to-mode)))
(global-set-key (kbd "RET") 'autopairs-ret)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; (un)comment region or line with C-c C-c ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
	(setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))
(global-set-key (kbd "C-c C-c") 'comment-or-uncomment-region-or-line)

(setq make-backup-files nil)

;;;;;;;;;;;;;;;;;;;;;
;;;   YASnippet   ;;;
;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elpa/yasnippet-20181015.1212")
(require 'yasnippet)
(yas-global-mode 1)

;;;;;;;;;;;;;;;;;;;;;
;;;    TS Mode    ;;;
;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/ts-mode")
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx$" . typescript-mode))
(autoload 'ts-mode "ts-mode" "TS mode" t)

;;;;;;;;;;;;;;;;;;;;;
;;;      JSX      ;;;
;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . jsx-mode))
(autoload 'jsx-mode "jsx-mode" "JSX mode" t)

;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Auto-Complete Mode ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; should be loaded after yasnippet so that they can work together
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
;;; set the trigger key so that it can work together with yasnippet on tab key,
;;; if the word exists in yasnippet, pressing tab will cause yasnippet to
;;; activate, otherwise, auto-complete will
(ac-set-trigger-key "TAB")
(ac-set-trigger-key "<tab>")

;;;;;;;;;;;;;;;;;;;;;
;;; Less Css Mode ;;;
;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/elpa/less-css-mode-20140919.524")
(require 'less-css-mode)

;;;;;;;;;;;;;;;;;;;;;;;
;;; Make shell work ;;;
;;;;;;;;;;;;;;;;;;;;;;;
(setq explicit-shell-file-name "C:/cygwin64/bin/bash.exe")
(setq shell-file-name explicit-shell-file-name)
(add-to-list 'exec-path "C:/cygwin64/bin")

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; More Auto-Complete Mode? ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/autocomplete-1.3.1")
(require 'auto-complete)
(global-auto-complete-mode t)
 
(require 'auto-complete-config)
(ac-ropemacs-initialize)
(global-auto-complete-mode t)
(define-key ac-complete-mode-map "\t" 'ac-expand)
(define-key ac-complete-mode-map "\r" 'ac-complete)
(define-key ac-complete-mode-map "\M-n" 'ac-next)
(define-key ac-complete-mode-map "\M-p" 'ac-previous)
(setq ac-auto-start 3)
(setq ac-dwim t)
(set-default 'ac-sources '(ac-source-abbrev ac-source-words-in-buffer))
(setq ac-modes
         (append ac-modes
                 '(eshell-mode
                         )))

;;;;;;;;;;;;;;;;;;;;
;;;   Web Mode   ;;;
;;;;;;;;;;;;;;;;;;;;
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.js?\\'" . web-mode)) ;; We have other things for js
;(setq web-mode-extra-auto-pairs
;      '(("js"  . (("'" "'")))))
;(setq web-mode-enable-auto-pairing t)
;(setq web-mode-disable-auto-pairing nil)
(setq web-mode-enable-css-colorization t)
(setq web-mode-enable-current-element-highlight t)
(set-face-attribute 'web-mode-html-tag-face nil :foreground "#33f")
(set-face-attribute 'web-mode-current-element-highlight-face nil :background "#ddd")
;;(define-key web-mode-map (kbd "TAB") 'web-mode-attribute-end)
(define-key web-mode-map (kbd "TAB") 'indent-for-tab-command)
(setq web-mode-enable-auto-expanding t)

;;;;;;;;;;;;;;;;;;;;;
;;;    js2 Mode   ;;;
;;;;;;;;;;;;;;;;;;;;;
(require 'js2-mode)
(add-to-list 'auto-mode-alist '("\\.js?\\'" . js2-mode))

;;;;;;;;;;;;;;;;;;;;;
;;; Smooth Scroll ;;;
;;;;;;;;;;;;;;;;;;;;;
;; I don't really like it
;;(require 'smooth-scroll)
;;(smooth-scroll-mode t)

;;let's try this instead, from http://stackoverflow.com/questions/3631220/fix-to-get-smooth-scrolling-in-emacs
(setq redisplay-dont-pause t
      scroll-margin 1
      scroll-step 1
      scroll-conservatively 10000
      scroll-preserve-screen-position 1)

(put 'upcase-region 'disabled nil)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; hfyview (view in browser) ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(add-to-list 'load-path "~/.emacs.d/hfyview")
(require 'hfyview)
(global-set-key (kbd "C-x C-p") 'hfyview-buffer)

;;;;;;;;;;;;;;;;;;;;
;;;    Go Mode   ;;;
;;;;;;;;;;;;;;;;;;;;

(add-hook 'go-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)
	    (setq tab-width 2)))

;;;;;;;;;;;;;;;;;;;;
;;;  LaTeX Mode  ;;;
;;;;;;;;;;;;;;;;;;;;

(add-hook 'LaTeX-mode-hook
	  (lambda ()
	    (setq preview-image-type 'pnm)))

(add-hook 'LaTeX-mode-hook
          'fix-electric-pair-paired-delimiters-in-tex-mode)

(defun fix-electric-pair-paired-delimiters-in-tex-mode ()
  (add-function
   :around
   (local 'electric-pair-skip-self)
   (lambda (oldfun c)
     (pcase (electric-pair-syntax-info c)
       (`(,syntax ,_ ,_ ,_)
        (if (eq syntax ?$)
            (unwind-protect
                (progn
                  (delete-char -1)
                  (texmathp))
              (insert-char c))
          (funcall oldfun c)))))
   '((name . fix-electric-pair-paired-delimiters-in-tex-mode))))

;;; .emacs ends here
