(setq el-get-dir (file-truename ".emacs.d/el-get"))
(add-to-list 'load-path (file-truename ".emacs.d/el-get/el-get"))
(load-file "el-get-install.el")

(setq el-get-sources
      (list (append '(:branch "release_7.9.3f"
                      :shallow t
                     ) (el-get-read-recipe 'org-mode))))
(el-get 'sync (mapcar 'el-get-source-name el-get-sources))

(require 'org-install)
(require 'org-export)
(require 'org-e-latex)
(require 'org-exp-blocks)

;; Configure Babel to support all languages included in the manuscript
(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (ruby . t)
   (gnuplot . t)
   (sh . t)
   (R . t)
   (org        . t)))
(setq org-confirm-babel-evaluate nil)
(setq toggle-debug-on-error t)

;; Configure Org-mode
  (setq org-export-latex-hyperref-format "\\ref{%s}")
  (setq org-entities-user nil)
  (add-to-list 'org-entities-user '("space" "\\ " nil " " " " " " " "))
  (setq org-e-latex-pdf-process '("texi2dvi --clean --verbose --batch %f"))
  (setq org-export-latex-classes nil)
  (setq org-export-latex-packages-alist nil)
  (add-to-list 'org-export-latex-packages-alist '("" "hyperref"))
  (add-to-list 'org-export-latex-packages-alist '("" "graphicx"))

  (require 'org-special-blocks)

(org-add-link-type
   "cite" nil
   (lambda (path desc format)
     (cond
      ((eq format 'latex)
             (format "\\cite{%s}" path)))))

(org-add-link-type
   "acm" nil
   (lambda (path desc format)
     (cond
      ((eq format 'latex)
             (format "{\\%s{%s}}" path desc)))))

(add-to-list 'org-export-latex-classes
               '("acm-proc-article-sp"
                 "\\documentclass{acm_proc_article-sp}
              [NO-DEFAULT-PACKAGES]
              [PACKAGES]
              [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))
