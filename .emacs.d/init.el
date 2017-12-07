(add-to-list 'load-path "~/.emacs.d/packages")
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/emacs-color-theme-solarized")
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
(eval-when-compile
  (require 'use-package))
(require 'better-defaults)
;;------------------------------------------------------------------------------------------
;; General settings - editing:
;;------------------------------------------------------------------------------------------
;; Turn off mouse interface early in startup to avoid momentary flash
;; of things I don't want.
(progn
  (dolist (mode '(menu-bar-mode tool-bar-mode scroll-bar-mode))
    (when (fboundp mode) (funcall mode -1))))

;; Don't show the splash screen
(setq inhibit-startup-screen t
      ;; Show the *scratch* on startup
      initial-buffer-choice t)

;; I got sick of typing "yes"
(defalias 'yes-or-no-p 'y-or-n-p)

;; I prefer spaces over tabs
(setq-default
 indent-tabs-mode nil
 ;; ... and I prefer 4-space indents
 tab-width 4)

;; UTF-8 please!
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

;; Don't clobber things in the system clipboard when killing
(setq save-interprogram-paste-before-kill t)

;; nuke trailing whitespace when writing to a file
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; always add a trailing newline - it's POSIX
(setq require-final-newline t)
;; enable hl-line-mode for prog-mode
;; (add-hook 'prog-mode-hook 'hl-line-mode)
;;-----------------------------------------------------------------------------------------
;;interface settings
;;-----------------------------------------------------------------------------------------
;;; global interface changes

;; always highlight syntax
(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)

;; Highlight matching parentheses
(show-paren-mode 1)
(setq show-paren-style 'parenthesis)

;; show keystrokes
(setq echo-keystrokes 0.1)

;; Always show line number in the mode line
(line-number-mode 1)
;; ... and show the column number
(column-number-mode 1)

;; Show bell
(setq visible-bell t)

;; auto-pad linum-mode according to length of buffer
;; (setq nlinum-format (lambda (line)
;;   (propertize
;;    (format (concat " %"
;;                    (number-to-string
;;                     (length (number-to-string
;;                              (line-number-at-pos (point-max)))))
;;                    "d ")
;;            line)
;;    'face 'linum)))
;; load solarized in terminal mode
(if (not (display-graphic-p))
  (progn
  (load-theme 'solarized t))
  (load-theme 'doom-one t)
)

;;------------------------------------------------------------------------------------------
;; End of General Settings
;;------------------------------------------------------------------------------------------
(use-package nlinum
  :ensure t
  :config
  (global-nlinum-mode)); (use-package better-defaults :ensure t)

(require 'evil-init)
(use-package flyspell-popup :ensure t)
(use-package ivy :ensure t
  :init (ivy-mode 1)
  :config
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  )
;; (use-package spacemacs-theme :ensure t
  ;; :defer t
  ;; :init (load-theme 'spacemacs-dark t)
  ;; )
;(when (display-graphic-p)
  (use-package doom-themes :ensure t
    ;:defer t
    :init
    ;; Global settings (defaults)
    (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
          doom-themes-enable-italic t) ; if nil, italics is universally disabled
    :config
    ;; Enable flashing mode-line on errors
    (doom-themes-visual-bell-config)

    ;; Enable custom neotree theme
    (doom-themes-neotree-config)  ; all-the-icons fonts must be installed!

    ;; Corrects (and improves) org-mode's native fontification.
    (doom-themes-org-config))
;)

(use-package elpy :ensure t
  :config
  (elpy-enable)
  (elpy-use-ipython)
  )
(use-package exec-path-from-shell :ensure t)
(use-package flycheck :ensure t
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook
            (lambda ()
              (flyspell-prog-mode)
              (flycheck-mode)
              ))
  )
(use-package xclip :ensure t)
(use-package ein :ensure t
  :config
  ;;load theme for better visual aid in ein notebook
  (when (display-graphic-p)
    (load-theme 'doom-peacock))

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
                                        ;(evil-leader/set-key-for-mode 'ein:connect-mode
  )
(use-package yaml-mode :ensure t)
;; (use-package magit :ensure t)
;; (use-package evil-magit :ensure t)
(use-package evil-nerd-commenter :ensure t)
(use-package evil-surround
  :ensure t
  :config
  (global-evil-surround-mode 1)
  )
(use-package powerline-evil :ensure t
  :config (powerline-evil-center-color-theme)
  )
(use-package org
  :ensure t
  :defer t
  )
;;_______________________________________________________
;;Share clipboard when in term.
(defun noct:conditionally-turn-on-xclip-mode (_)
  (unless (display-graphic-p)
    (xclip-mode)))
(noct:conditionally-turn-on-xclip-mode nil)
(add-hook 'after-make-frame-functions
          #'noct:conditionally-turn-on-xclip-mode)
;;flyspell
;; flyspell-mode for spell checking in text-mode
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))
;; rerun spell check on current buffer upon personal dict changes
(defun flyspell-buffer-after-pdict-save (&rest _)
  (flyspell-buffer))

(advice-add 'ispell-pdict-save :after #'flyspell-buffer-after-pdict-save)
;;
;; built in mode settings
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
;; enalbe company completion in all buffers
(add-hook 'after-init-hook 'global-company-mode)
(set-display-table-slot standard-display-table 'wrap ?\ )

;; (define-key key-translation-map (kbd "s-c") (kbd "C-c"))
;;-----------------------------------------------------------------------
;;_______________________________________________________
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "31e64af34ba56d5a3e85e4bebefe2fb8d9d431d4244c6e6d95369a643786a40e" "4b207752aa69c0b182c6c3b8e810bbf3afa429ff06f274c8ca52f8df7623eb60" "ba3dc5b711a58e65dbf677ab5307dd5735fe56e5d3f08abd584ca73b15abdd07" "0fd8c1b09c6c9e7116054f3fe5929775d9e9d5e49b9d1bf62dfdd5283416168e" "4a7abcca7cfa2ccdf4d7804f1162dd0353ce766b1277e8ee2ac7ee27bfbb408f" "10e3d04d524c42b71496e6c2e770c8e18b153fcfcc838947094dad8e5aa02cef" "d2c61aa11872e2977a07969f92630a49e30975220a079cd39bec361b773b4eb3" default)))
 '(ein:jupyter-default-server-command "/usr/local/bin/jupyter")
 '(frame-background-mode (quote dark))
 '(package-selected-packages
   (quote
    (magit powerline-evil evil-surround evil-nerd-commenter evil-leader yaml-mode ein xclip flycheck exec-path-from-shell elpy spacemacs-theme ivy evil better-defaults use-package)))
 '(solarized-termcolors 256)
 '(xclip-select-enable-clipboard nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
