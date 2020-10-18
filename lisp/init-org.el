(require 'org-capture)

(use-package 
  org 
  :ensure t)

;; 美化org
(use-package 
  org-bullets
  :ensure t
  :hook ('org-mode . 'org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("☰" "☷" "✿" "☭")))

(provide 'init-org)
