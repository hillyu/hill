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
(setq locale-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-selection-coding-system 'utf-8)
(prefer-coding-system 'utf-8)
(when (display-graphic-p)
   (setq x-select-request-type '(UTF8_STRING COMPOUND_TEXT TEXT STRING)))
;; Don't clobber things in the system clipboard when killing
(setq save-interprogram-paste-before-kill t)

;; nuke trailing whitespace when writing to a file
(add-hook 'write-file-hooks 'delete-trailing-whitespace)

;; always add a trailing newline - it's POSIX
(setq require-final-newline t)
;; mutt mail support auto mail mode
(setq auto-mode-alist (append '(("/home/hill/.config/mutt/tmp/neomutt*" . mail-mode)) auto-mode-alist))
;; enable hl-line-mode for prog-mode
;; (add-hook 'prog-mode-hook 'hl-line-mode)
;;-----------------------------------------------------------------------------------------
;;interface settings
;;-----------------------------------------------------------------------------------------
;;; global interface changes
;; vim like sentence ending
(setf sentence-end-double-space nil)
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
  ;; last t is for NO-ENABLE
(load-theme 'solarized t t)
;; (load-theme 'solarized t)
(set-terminal-parameter nil 'background-mode 'dark)
(set-frame-parameter nil 'background-mode 'dark)
(setq frame-background-mode 'dark)
;; (load-theme 'doom-peacock t t)
;; (load-theme 'spacemacs-light t t)
(add-hook 'after-make-frame-functions
          (lambda(frame)
            (if (window-system frame)
                (progn
                  ;; (set-terminal-parameter frame 'background-mode 'light)
                  (set-frame-parameter frame 'background-mode 'light)
                  (setq frame-background-mode 'light)
                  (frame-set-background-mode frame)
                  (enable-theme 'solarized)
                  )
              (progn
                ;; (disable-theme 'solarized) ; in case it was active
                (set-terminal-parameter frame 'background-mode 'dark)
                ;; (set-frame-parameter frame 'background-mode 'dark)
                (setq frame-background-mode 'dark)
                (frame-set-background-mode frame)
                (enable-theme 'solarized)
            ))))

;; For when started with emacs or emacs -nw rather than emacs --daemon
(if window-system
  (progn
    (set-terminal-parameter nil 'background-mode 'light)
    (set-frame-parameter nil 'background-mode 'light)
    (setq frame-background-mode 'light)
    (enable-theme 'solarized)
    )
  (progn
    (set-terminal-parameter nil 'background-mode 'dark)
    (set-frame-parameter nil 'background-mode 'dark)
    (setq frame-background-mode 'dark)
    (enable-theme 'solarized)
    ))
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
  (setq ivy-wrap t)
  (define-key ivy-minibuffer-map (kbd "TAB") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "<tab>") 'ivy-next-line)
  (define-key ivy-minibuffer-map (kbd "S-TAB") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "<backtab>") 'ivy-previous-line)
  (define-key ivy-minibuffer-map (kbd "RET") 'ivy-alt-done)
  (define-key ivy-minibuffer-map (kbd "<S-return>") 'ivy-immediate-done)
  (define-key ivy-minibuffer-map [escape] 'minibuffer-keyboard-quit)
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
              (flycheck-mode)
              ))
  )
(use-package xclip :ensure t
  ;;Share clipboard when in term.
  :config
  (defun noct:conditionally-turn-on-xclip-mode (_)
    (unless (display-graphic-p)
      (xclip-mode)))
  (noct:conditionally-turn-on-xclip-mode nil)
  (add-hook 'after-make-frame-functions
            #'noct:conditionally-turn-on-xclip-mode))
(use-package rainbow-delimiters :ensure t
  :config
  (add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
  )
(use-package ein :ensure t
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
  (setq powerline-evil-tag-style 'verbose)
  )
(use-package org
  :ensure t
  :defer t
  :config
  (setq org-todo-keywords '((sequence "☛ TODO(t)" "|" "✔ DONE(d)")
                            (sequence "⚑ WAITING(w)" "|")
                            (sequence "|" "✘ CANCELED(c)")))
  )
(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )
;;_______________________________________________________

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
;; set super to ctrl on non darwin system.
(if (not (eq system-type 'darwin))
    (progn
    (define-key key-translation-map (kbd "s-a") (kbd "C-a"))
    (define-key key-translation-map (kbd "s-b") (kbd "C-b"))
    (define-key key-translation-map (kbd "s-c") (kbd "C-c"))
    (define-key key-translation-map (kbd "s-d") (kbd "C-d"))
    (define-key key-translation-map (kbd "s-e") (kbd "C-e"))
    (define-key key-translation-map (kbd "s-f") (kbd "C-f"))
    (define-key key-translation-map (kbd "s-g") (kbd "C-g"))
    (define-key key-translation-map (kbd "s-h") (kbd "C-h"))
    (define-key key-translation-map (kbd "s-i") (kbd "C-i"))
    (define-key key-translation-map (kbd "s-j") (kbd "C-j"))
    (define-key key-translation-map (kbd "s-k") (kbd "C-k"))
    (define-key key-translation-map (kbd "s-l") (kbd "C-l"))
    (define-key key-translation-map (kbd "s-m") (kbd "C-m"))
    (define-key key-translation-map (kbd "s-n") (kbd "C-n"))
    (define-key key-translation-map (kbd "s-o") (kbd "C-o"))
    (define-key key-translation-map (kbd "s-p") (kbd "C-p"))
    (define-key key-translation-map (kbd "s-q") (kbd "C-q"))
    (define-key key-translation-map (kbd "s-r") (kbd "C-r"))
    (define-key key-translation-map (kbd "s-s") (kbd "C-s"))
    (define-key key-translation-map (kbd "s-t") (kbd "C-t"))
    (define-key key-translation-map (kbd "s-u") (kbd "C-u"))
    (define-key key-translation-map (kbd "s-v") (kbd "C-v"))
    (define-key key-translation-map (kbd "s-w") (kbd "C-w"))
    (define-key key-translation-map (kbd "s-x") (kbd "C-x"))
    (define-key key-translation-map (kbd "s-y") (kbd "C-y"))
    (define-key key-translation-map (kbd "s-z") (kbd "C-z"))
    ))
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
    ("fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "8db4b03b9ae654d4a57804286eb3e332725c84d7cdab38463cb6b97d5762ad26" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "31e64af34ba56d5a3e85e4bebefe2fb8d9d431d4244c6e6d95369a643786a40e" "4b207752aa69c0b182c6c3b8e810bbf3afa429ff06f274c8ca52f8df7623eb60" "ba3dc5b711a58e65dbf677ab5307dd5735fe56e5d3f08abd584ca73b15abdd07" "0fd8c1b09c6c9e7116054f3fe5929775d9e9d5e49b9d1bf62dfdd5283416168e" "4a7abcca7cfa2ccdf4d7804f1162dd0353ce766b1277e8ee2ac7ee27bfbb408f" "10e3d04d524c42b71496e6c2e770c8e18b153fcfcc838947094dad8e5aa02cef" "d2c61aa11872e2977a07969f92630a49e30975220a079cd39bec361b773b4eb3" default)))
 '(ein:jupyter-default-server-command "/usr/local/bin/jupyter")
 '(package-selected-packages
   (quote
    (magit powerline-evil evil-surround evil-nerd-commenter evil-leader yaml-mode ein xclip flycheck exec-path-from-shell elpy spacemacs-theme ivy evil better-defaults use-package)))
 '(solarized-termcolors 256)
 '(x-select-enable-clipboard-manager nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ein:cell-input-area ((t (:background "brblack")))))
