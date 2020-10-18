(setq package-archives '(("gnu" . "https://mirrors.ustc.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.ustc.edu.cn/elpa/melpa/")
                         ("melpa-stable" . "https://mirrors.ustc.edu.cn/elpa/melpa-stable/")
                         ("org" . "https://mirrors.ustc.edu.cn/elpa/org/")
                  	 ("melpa-tuna" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
(add-to-list 'load-path "~/.emacs.d/code/use-package")
(add-to-list 'load-path "~/.emacs.d/code/emacs-application-framework")
(add-to-list 'load-path "~/.emacs.d/code/page-break-lines")
(add-to-list 'load-path "~/.emacs.d/code/awesome-pair")
(add-to-list 'load-path "~/.emacs.d/code/lsp-mode")

(require 'use-package)

(require 'lsp-mode)

(require 'awesome-pair)
(use-package posframe
  :ensure t)

;; 竖线
(use-package 
  page-break-lines 
  :ensure t
  :hook (after-init . page-break-lines-mode)
  :config (turn-on-page-break-lines-mode))

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (setq dashboard-center-content t)
  (setq dashboard-set-heading-icons t)
  (setq dashboard-set-file-icons t)
  (dashboard-modify-heading-icons '((recents . "file-text")
                                    (bookmarks . "book")))
  (setq dashboard-banner-logo-title
        "              欢迎主人                    ")
  (setq dashboard-startup-banner 'logo)
  (setq dashboard-set-navigator t))

;; 括号匹配
(use-package 
  smartparens 
  :ensure t 
  :hook ('prog-mode . 'smartparens-global-mode))
;; 有道词典，非常有用
(use-package 
  youdao-dictionary 
  :defer 2 
  :ensure t 
  :config (setq url-automatic-caching t) 
  (which-key-add-key-based-replacements "C-x y" "有道翻译") 
  :bind (("C-x y t" . 'youdao-dictionary-search-at-point+) 
         ("C-x y g" . 'youdao-dictionary-search-at-point-posframe) 
         ("C-x y p" . 'youdao-dictionary-play-voice-at-point) 
         ("C-x y r" . 'youdao-dictionary-search-and-replace) 
         ("C-x y i" . 'youdao-dictionary-search-from-input)))

;; 彩虹括号
(use-package 
  rainbow-delimiters
  :defer 2
  :ensure t 
  :config
  ;; 设置每一级括号的颜色
  (set-face-foreground 'rainbow-delimiters-depth-1-face "chartreuse3") 
  (set-face-foreground 'rainbow-delimiters-depth-2-face "DodgerBlue1") 
  (set-face-foreground 'rainbow-delimiters-depth-3-face "DarkOrange2")
  (set-face-foreground 'rainbow-delimiters-depth-4-face "deep pink") 
  (set-face-foreground 'rainbow-delimiters-depth-5-face "medium orchid") 
  (set-face-foreground 'rainbow-delimiters-depth-6-face "turquoise") 
  (set-face-foreground 'rainbow-delimiters-depth-7-face "lime green") 
  (set-face-foreground 'rainbow-delimiters-depth-8-face "gold") 
  (set-face-foreground 'rainbow-delimiters-depth-9-face "cyan") 
  (set-face-bold 'rainbow-delimiters-depth-1-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-2-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-3-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-4-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-5-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-6-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-7-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-8-face "t") 
  (set-face-bold 'rainbow-delimiters-depth-9-face "t") 
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode))
(save-place-mode 1)
(set-cursor-color "green2")


;; 增强了搜索功能
(use-package swiper
  :bind
  (("C-s" . swiper)
   ("C-r" . swiper)
   ("C-c C-r" . ivy-resume)
   ("M-x" . counsel-M-x)
   ("C-x C-f" . counsel-find-file))
  :config
  (progn
    (ivy-mode 1)
    (setq ivy-use-virtual-buffers t)
    (setq ivy-display-style 'fancy)
    (define-key read-expression-map (kbd "C-r") 'counsel-expression-history)))

;; 饥饿删除（一次性删除多个连续的空白符）
(use-package hungry-delete
  :ensure t
  :defer 2
  :hook ('prog-mode . 'global-hungry-delete-mode))
;; 强大的字符跳转工具
(use-package avy 
  :ensure t
  :defer 2
  :bind (("M-g :" . 'avy-goto-char)
         ("M-g '" . 'avy-goto-char-2)
         ("M-g \"" . 'avy-goto-char-timer)
         ("M-g f" . 'avy-goto-line)
         ("M-g w" . 'avy-goto-word-1)
         ("M-g e" . 'avy-goto-word-0)))
;; 集成了很多非常有用的的功能
(use-package counsel
  :ensure t
  :defer 2
  :bind
  (("C-x C-r" . 'counsel-recentf) 
   ("C-x d" . 'counsel-dired))
  :config
  ;; 默认的 rg 配置
  ;; (setq counsel-rg-base-command "rg -M 240 --with-filename --no-heading --line-number --color never %s")
  (setq counsel-rg-base-command (list "rg" "-M" "240" "--with-filename" "--no-heading" "--line-number" "--color" "never" "%s" "-g" "!package-config.org" "-g" "!site-lisp"))
  (setq counsel-fzf-cmd "fd --exclude={site-lisp,elpa/,etc/snippets} --type f | fzf -f \"%s\" --algo=v1")
  ;; Integration with `projectile'
  (with-eval-after-load 'projectile
    (setq projectile-completion-system 'ivy)))
;; 跳转窗口
(use-package ace-window
  :ensure t
  :defer 2
  :init
  (progn
    (global-set-key [remap other-window] 'ace-window)
	;; 设置标记
    (custom-set-faces
     '(aw-leading-char-face
       ((t (:inherit ace-jump-face-foreground :height 3.0 :foreground "magenta")))))))
(use-package which-key
  :ensure
  :defer 2
  :custom
  (which-key-popup-type 'side-window)
  :config
  (which-key-mode))


;; counsel提供对项目管理的支持
(use-package 
  counsel-projectile 
  :ensure t
  :defer 2
  :hook ((counsel-mode . counsel-projectile-mode)) 
  :init (setq counsel-projectile-grep-initial-input '(ivy-thing-at-point)))
(use-package all-the-icons-ivy-rich
             :ensure t
             :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
             :ensure t
             :init (ivy-rich-mode 1)
             (setcdr (assq t ivy-format-functions-alist) #'ivy-format-function-line)
             :config (setq ivy-rich-display-transformers-list '(ivy-switch-buffer
								(:columns ((ivy-rich-switch-buffer-icon
									    (:width 2))
									   (ivy-rich-candidate
									    (:width 30))
									   (ivy-rich-switch-buffer-size
									    (:width 7))
									   (ivy-rich-switch-buffer-indicators
									    (:width 4
										    :face error
										    :align right))
									   (ivy-rich-switch-buffer-major-mode
									    (:width 12
										    :face warning))
									   (ivy-rich-switch-buffer-project
									    (:width 15
										    :face success))
									   (ivy-rich-switch-buffer-path
									    (:width (lambda (x)
										      (ivy-rich-switch-buffer-shorten-path
										       x
										       (ivy-rich-minibuffer-width
											0.3))))))
									  :predicate (lambda (cand)
										       (get-buffer cand)))
								counsel-find-file
								(:columns ((ivy-read-file-transformer)
									   (ivy-rich-counsel-find-file-truename
									    (:face font-lock-doc-face))))
								counsel-M-x
								(:columns ((counsel-M-x-transformer
									    (:width 40))
									   (ivy-rich-counsel-function-docstring
									    (:face font-lock-doc-face))))
								counsel-recentf
								(:columns ((ivy-rich-candidate
									    (:width 0.8))
									   (ivy-rich-file-last-modified-time
									    (:face font-lock-comment-face)))) 
								counsel-describe-function
								(:columns
								 ((counsel-describe-function-transformer
								   (:width 40))
								  (ivy-rich-counsel-function-docstring
								   (:face font-lock-doc-face))))
								counsel-describe-variable
								(:columns
								 ((counsel-describe-variable-transformer
								   (:width 40))
								  (ivy-rich-counsel-variable-docstring
								   (:face font-lock-doc-face))))
								)))
(use-package ivy-posframe
             :ensure t
             :init (ivy-posframe-mode 1)
             (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center))))


(provide 'init-packages)
