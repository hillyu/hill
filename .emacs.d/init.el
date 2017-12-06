;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;; -----------------------------------------------------------------
;; Install Package automatically
(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (url (concat (if no-ssl "http" "https") "://melpa.org/packages/")))
  (add-to-list 'package-archives (cons "melpa" url) t))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
;(add-to-list 'package-archives
             ;'("MELPA" . "http://melpa.org/packages/") t)
(add-to-list 'package-archives
             '("elpy" . "http://jorgenschaefer.github.io/packages/"))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(evil
    better-defaults
    ivy
    spacemacs-theme
    elpy
    exec-path-from-shell
    flycheck
    xclip
    ;py-autopep8
    ein
    yaml-mode
    magit
    evil-magit
    evil-leader
    evil-nerd-commenter
    evil-surround
    powerline-evil))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)
;; load better-defaults
(require 'better-defaults) 
;; ivy
(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
;; solve mac env path not defined in non-term emacs
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; by default c-u is reserved in evil mode so we need to enable it, needs to be called before (require evil)
(setq evil-want-C-u-scroll t)
;; c-c c-v copy in emacs gui, terminal emacs is fine as it is provied by terminal
(cua-mode t)
    (setq cua-auto-tabify-rectangles nil) ;; Don't tabify after rectangle commands
    (setq cua-keep-region-after-copy t) ;; Standard Windows behaviour
(require 'powerline-evil)
(require 'evil)
;; Evil Magit
(require 'evil-magit)
;; Evil Leader - provide vim leader key functions
(require 'evil-leader)
;;elpy
(elpy-enable)
(elpy-use-ipython)

;;Share clipboard when in term.

(defun noct:conditionally-turn-on-xclip-mode (_)
  (unless (display-graphic-p)
    (xclip-mode)))

(noct:conditionally-turn-on-xclip-mode nil)

(add-hook 'after-make-frame-functions
          #'noct:conditionally-turn-on-xclip-mode)
;; flycheck for real time syntax checking
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook
            (lambda ()
              (flyspell-prog-mode)
              (flycheck-mode)
              )))
;pep8 enforcing while on saving, removing trailing line etc.
;(require 'py-autopep8)
;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;; rebind tab completion
(with-eval-after-load 'company
  (define-key company-active-map (kbd "M-n") nil)
  (define-key company-active-map (kbd "M-p") nil)
  (define-key company-active-map (kbd "TAB") 'company-complete-common-or-cycle)
  (define-key company-active-map (kbd "<tab>") 'company-complete-common-or-cycle)
  ;(define-key company-active-map [tab] #'company-select-next)
  ;(define-key company-active-map (kbd "<backtab>") #'company-select-previous)
  (define-key company-active-map (kbd "S-TAB") 'company-select-previous)
  (define-key company-active-map (kbd "<backtab>") 'company-select-previous)
  (setq company-selection-wrap-around t)
  ;; show 1st candidate, type anything not matching will cancel tooptip 
  (setq company-frontends
      '(company-pseudo-tooltip-unless-just-one-frontend
        company-preview-frontend
        company-echo-metadata-frontend))
  
  )
;; set super to ctrl
(define-key key-translation-map (kbd "s-w") (kbd "C-w"))
(define-key key-translation-map (kbd "s-g") (kbd "C-g"))
(define-key key-translation-map (kbd "s-h") (kbd "C-h"))
(define-key key-translation-map (kbd "s-a") (kbd "C-a"))
(define-key key-translation-map (kbd "s-e") (kbd "C-e"))
(define-key key-translation-map (kbd "s-x") (kbd "C-x"))
;; (define-key key-translation-map (kbd "s-c") (kbd "C-c"))
;; flyspell-mode for spell checking in text-mode
(dolist (hook '(text-mode-hook))
      (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
      (add-hook hook (lambda () (flyspell-mode -1))))
;; rerun spell check on current buffer upon personal dict changes
(defun flyspell-buffer-after-pdict-save (&rest _)
  (flyspell-buffer))

(advice-add 'ispell-pdict-save :after #'flyspell-buffer-after-pdict-save)

;;flyspell autochoose menu method, gui: natvie term: popup


(defun flyspell-emacs-popup-textual (event poss word)
      "A textual flyspell popup menu."
      (require 'popup)
      (let* ((corrects (if flyspell-sort-corrections
                           (sort (car (cdr (cdr poss))) 'string<)
                         (car (cdr (cdr poss)))))
             (cor-menu (if (consp corrects)
                           (mapcar (lambda (correct)
                                     (list correct correct))
                                   corrects)
                         '()))
             (affix (car (cdr (cdr (cdr poss)))))
             show-affix-info
             (base-menu  (let ((save (if (and (consp affix) show-affix-info)
                                         (list
                                          (list (concat "Save affix: " (car affix))
                                                'save)
                                          '("Accept (session)" session)
                                          '("Accept (buffer)" buffer))
                                       '(("Save word" save)
                                         ("Accept (session)" session)
                                         ("Accept (buffer)" buffer)))))
                           (if (consp cor-menu)
                               (append cor-menu (cons "" save))
                             save)))
             (menu (mapcar
                    (lambda (arg) (if (consp arg) (car arg) arg))
                    base-menu)))
        (cadr (assoc (popup-menu* menu :scroll-bar t) base-menu))))
(defun flyspell-emacs-popup-choose (org-fun event poss word)
    (if (window-system)
        (funcall org-fun event poss word)
      (flyspell-emacs-popup-textual event poss word)))
(eval-after-load "flyspell"
      '(progn
          (advice-add 'flyspell-emacs-popup :around #'flyspell-emacs-popup-choose)))

;;-----------------------------------------------------------------------
;;Theme related
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
;; theme solarized dark from sellout
;; (load-theme 'solarized t)
;; disable toolbar, mac/linux x
(tool-bar-mode -1)
;;
;;-----------------------------------------------------------------------
;;You should enable global-evil-leader-mode before you enable evil-mode
(global-evil-leader-mode)
(evil-leader/set-leader ";")
;;vim mode leader /key binding for nerdCommenter
(evil-leader/set-key
  ;; evil nerd comment
  "c SPC" 'evilnc-comment-or-uncomment-lines
  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
  ;"ll" 'evilnc-quick-comment-or-uncomment-to-the-line
  "cc" 'evilnc-copy-and-comment-lines
  "cp" 'evilnc-comment-or-uncomment-paragraphs
  "cr" 'comment-or-uncomment-region
  "cv" 'evilnc-toggle-invert-comment-line-by-line
  "."  'evilnc-copy-and-comment-operator
  "," 'evilnc-comment-operator ; if you prefer backslash key
  ;; ein initiate command
  "js" 'ein:jupyter-server-start
  "jl" 'ein:notebooklist-login
  "jo" 'ein:notebooklist-open
  ;; text related,
  ;;1. spell.
  ;; call selection window == mid click in gui
  ;; "ss" 'flyspell-correct-word-before-point'
  "ss" 'flyspell-popup-correct
  ;; 
  "sw" 'ispell-word
  "sa" 'flyspell-buffer
  "sf" 'flyspell-mode
  "s SPC" 'flyspell-goto-next-error
)
(evil-leader/set-key-for-mode 'ein:notebook-multilang-mode 
  ;; evil ein 
  "SPC" 'ein:worksheet-execute-cell-and-goto-next
  "xc" 'ein:worksheet-execute-cell
  "xa" 'ein:worksheet-execute-all-cell
  "l" 'ein:worksheet-clear-output
  ;;"sl" 'ein:worksheet-clear-all-output
  "d" 'ein:worksheet-kill-cell
  "a" 'ein:worksheet-insert-cell-above
  "b" 'ein:worksheet-insert-cell-below
  "tc" 'ein:worksheet-toggle-cell-type
  "ts" 'ein:worksheet-toggle-slide-type
  "u" 'ein:worksheet-change-cell-type
  ;;"s" 'ein:worksheet-merge-cell
  "<up>" 'ein:worksheet-move-cell-up
  "<down>" 'ein:worksheet-move-cell-down
  "f" 'ein:pytools-request-tooltip-or-help
  "i" 'ein:completer-complete
  "r" 'ein:notebook-restart-kernel-command
  "z" 'ein:notebook-kernel-interrupt-command
  "q" 'ein:notebook-kill-kernel-then-close-command
  "#" 'ein:notebook-close
  "y" 'ein:worksheet-copy-cell
  "p" 'ein:worksheet-yank-cell
  "j" 'ein:worksheet-goto-next-input
  "k" 'ein:worksheet-goto-prev-input
)
;(evil-leader/set-key-for-mode 'ein:connect-mode
  ;"SPC" 'ein:connect-run-or-eval-buffer
  
;)  
;; keybindings for ipython notebook traceback mode
(evil-leader/set-key-for-mode 'ein:traceback-mode
  "RET" 'ein:tb-jump-to-source-at-point-command
  "n" 'ein:tb-next-item
  "p" 'ein:tb-prev-item
  "q" 'bury-buffer
)

      ;; keybindings mirror ipython web interface behavior
      (evil-define-key 'insert ein:notebook-multilang-mode-map
        (kbd "<C-return>") 'ein:worksheet-execute-cell
        (kbd "<S-return>") 'ein:worksheet-execute-cell-and-goto-next)

      (evil-define-key 'normal ein:notebook-multilang-mode-map
        ;; keybindings mirror ipython web interface behavior
        (kbd "<C-return>") 'ein:worksheet-execute-cell
        (kbd "<S-return>") 'ein:worksheet-execute-cell-and-goto-next
        "gj" 'ein:worksheet-goto-next-input
        "gk" 'ein:worksheet-goto-prev-input)
;;Evil mode begin
(evil-mode 1)
;; nice power line indicator for vi mode
(powerline-evil-center-color-theme)
;; enable line numbers globally
(global-linum-mode t) 
;; Treat wrapped line scrolling as single lines
(define-key evil-normal-state-map (kbd "j") 'evil-next-visual-line)
(define-key evil-normal-state-map (kbd "k") 'evil-previous-visual-line)
;;; esc quits pretty much anything (like pending prompts in the minibuffer)
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)
;; Enable smash escape (ie 'jk' and 'kj' quickly to exit insert mode)
(define-key evil-insert-state-map "k" #'cofi/maybe-exit-kj)
(evil-define-command cofi/maybe-exit-kj ()
:repeat change
(interactive)
(let ((modified (buffer-modified-p)))
(insert "k")
(let ((evt (read-event (format "Insert %c to exit insert state" ?j)
nil 0.5)))
(cond
((null evt) (message ""))
((and (integerp evt) (char-equal evt ?j))
(delete-char -1)
(set-buffer-modified-p modified)
(push 'escape unread-command-events))
(t (setq unread-command-events (append unread-command-events
(list evt))))))))
(define-key evil-insert-state-map "j" #'cofi/maybe-exit-jk)
(evil-define-command cofi/maybe-exit-jk ()
:repeat change
(interactive)
(let ((modified (buffer-modified-p)))
(insert "j")
(let ((evt (read-event (format "Insert %c to exit insert state" ?k)
nil 0.5)))
(cond
((null evt) (message ""))
((and (integerp evt) (char-equal evt ?k))
(delete-char -1)
(set-buffer-modified-p modified)
(push 'escape unread-command-events))
(t (setq unread-command-events (append unread-command-events
(list evt))))))))

;;-----------------------------------------------------------------------
;;-----------------------------------------------------------------------
;; ORG MODE
;; auto-indent an org-mode file
(add-hook 'org-mode-hook
          (lambda()
            (local-set-key (kbd "C-c C-c") 'org-table-align)
            (local-set-key (kbd "C-c C-f") 'org-table-calc-current-TBLFM)
            (org-indent-mode t)))
;; enalbe company completion in all buffers
(add-hook 'after-init-hook 'global-company-mode)
(set-display-table-slot standard-display-table 'wrap ?\ )
;;-----------------------------------------------------------------------
;;Emacs-Lisp
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (flyspell-prog-mode)
            ))

;;-----------------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(ein:jupyter-default-server-command "/usr/local/bin/jupyter")
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
    (evil-leader exec-path-from-shell powerline-evil elpy)))
 '(x-select-enable-clipboard-manager nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
