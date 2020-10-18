(setq initial-frame-alist (quote ((fullscreen . maximized))))
(global-hl-line-mode 1)
(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)
;; 关闭文件滑动控件
(scroll-bar-mode -1)
;; 关闭工具栏
(tool-bar-mode -1)

;; 关闭菜单栏
(menu-bar-mode -1)
;;Theme
;; 主题包									
(use-package
  doom-themes
  :ensure t
  :defer)
(use-package
  spacemacs-common
  :ensure spacemacs-theme
  :defer)

;; (use-package base16-theme
;;   :ensure t
;;   :defer)

(use-package modus-operandi-theme
  :ensure t)

 ;; (load-file "~/.emacs.d/themes/solo-jazz-theme.el")

(use-package modus-vivendi-theme
  :ensure t)


;; 自动切换主题
(use-package
  circadian
  :ensure t
  :config
  ;; 经纬度，可以在https://www.latlong.net/获取，默认是广州的
  (setq calendar-latitude 23.130280
		calendar-longitude 113.288879)
  ;; sunrise 白天用的主题 sunset 晚上用的主题
  (setq circadian-themes '((:sunrise . modus-operandi)
						   (:sunset . modus-vivendi)))
  (circadian-setup)
  ;; 解决切换主题spaceline色块显示问题
  (add-hook 'circadian-after-load-theme-hook
			#'(lambda (theme)
				(spaceline-emacs-theme))))

;;Alpha
(set-frame-parameter nil 'alpha '(96 . 100))

;;Font Size
(set-face-attribute 'default nil :height 120)
(package-initialize) ;; You might already have this line
;; 自动刷新被修改过的文件
(global-auto-revert-mode 1)
;; 选中文本后输入会覆盖
(delete-selection-mode 1)

;; 更友好及平滑的滚动
(setq scroll-step 2
      scroll-margin 2
      hscroll-step 2
      hscroll-margin 2
      scroll-conservatively 101
      scroll-up-aggressively 0.01
      scroll-down-aggressively 0.01
      scroll-preserve-screen-position 'always)

;; 关闭自动调节行高
(setq auto-window-vscroll nil)
;; 关闭自动换行的功能
(setq truncate-partial-width-windows t)

;; 创建新行的动作
;; 回车时创建新行并且对齐
(global-set-key (kbd "RET") 'newline-and-indent)
;; 取消对齐创建的新行
(global-set-key (kbd "S-<return>") 'comment-indent-new-line)

;; 让光标无法离开视线
(setq mouse-yank-at-point nil)

;; 最大单行字符数量
(setq-default fill-column 80)

;; 让info帮助信息中关键字有高亮
(use-package 
  info-colors 
  :ensure t 
  :hook ('Info-selection-hook . 'info-colors-fontify-node))

;; 缩进线
(use-package
  indent-guide
  :ensure t
  :hook (prog-mode . indent-guide-mode))

;; 彩虹猫进度条
(use-package nyan-mode
  :ensure t
  :hook (after-init . nyan-mode)
  :config
  (setq nyan-wavy-trail t
		nyan-animate-nyancat nil))


;; 切换buffer焦点时高亮动画
(use-package beacon
  :ensure t
  :hook (after-init . beacon-mode))


;; 对齐表格
(use-package valign
  :disabled
  :load-path "~/.emacs.d/site-lisp/valign"
  :hook ((org-mode markdown-mode) . valign-mode)
  :config
  (setq valign-fancy-bar nil))

;; modeline样式
(use-package 
  doom-modeline
  :init (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 6)
  (doom-modeline-bar-width 3)
  (doom-modeline-buffer-file-name-style 'file-name))



;; tab-bar
(use-package tab-bar
  :config
  (setq tab-bar-tab-name-truncated-max 8))
;; 为上层提供 init-ui 模块

(add-to-list 'load-path "~/.emacs.d/code/lazycat-theme")
(require 'lazycat-theme)

(add-to-list 'load-path "~/.emacs.d/code/awesome-tab")
(require 'awesome-tab)

(provide 'init-ui)
