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
    spacemacs-theme
    elpy
    exec-path-from-shell
    flycheck
    ;py-autopep8
    ein
    yaml-mode
    magit
    evil-magit
    evil-leader
    evil-nerd-commenter
    powerline-evil))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)
;; load better-defaults
(require 'better-defaults) 
;; solve mac env path not defined in non-term emacs
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; by default c-u is reserved in evil mode so we need to enable it, needs to be called before (require evil)
(setq evil-want-C-u-scroll t)
(require 'powerline-evil)
(require 'evil)
;; Evil Magit
(require 'evil-magit)
;; Evil Leader - provide vim leader key functions
(require 'evil-leader)
;;elpy
(elpy-enable)
(elpy-use-ipython)

;; flycheck for real time syntax checking
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))
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
;;-----------------------------------------------------------------------
;;Theme related
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/emacs-color-theme-solarized")
;; theme solarized dark from sellout
;; (load-theme 'solarized t)
;; disable toolbar, mac/linux x
(tool-bar-mode -1)
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
)
(evil-leader/set-key-for-mode 'ein:notebook-multilang-mode 
  ;; evil ein 
  "SPC" 'ein:worksheet-execute-cell-and-goto-next
  "xc" 'ein:worksheet-execute-cell
  "xa" 'ein:worksheet-execute-all-cell
  "l" 'ein:worksheet-clear-output
  "sl" 'ein:worksheet-clear-all-output
  "d" 'ein:worksheet-kill-cell
  "a" 'ein:worksheet-insert-cell-above
  "b" 'ein:worksheet-insert-cell-below
  "tc" 'ein:worksheet-toggle-cell-type
  "ts" 'ein:worksheet-toggle-slide-type
  "u" 'ein:worksheet-change-cell-type
  "s" 'ein:worksheet-merge-cell
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
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (spacemacs-dark)))
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" default)))
 '(ein:jupyter-default-server-command "/usr/local/bin/jupyter")
 '(package-selected-packages
   (quote
    (evil-leader exec-path-from-shell powerline-evil elpy))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
