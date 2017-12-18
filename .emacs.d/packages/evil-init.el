(use-package evil :ensure t
  :init
  (progn
    ;; if we don't have this evil overwrites the cursor color
    (setq evil-default-cursor t)
    ;;enable c-u but need to be before evil-mode
    (setq evil-want-C-u-scroll t)
    ;; enable tab for org-cycle
    (setq evil-want-C-i-jump nil)
    ;; leader shortcuts
    ;; This has to be before we invoke evil-mode due to:
    ;; https://github.com/cofi/evil-leader/issues/10
    (use-package evil-leader :ensure t
      :init (global-evil-leader-mode)
      :config (progn
                (setq evil-leader/in-all-states t)
                (evil-leader/set-leader ";")
                ;;vim mode leader /key binding for nerdCommenter
                (evil-leader/set-key
                  ;; EVIL nerd comment
                  "c SPC" 'evilnc-comment-or-uncomment-lines
                  "cl" 'evilnc-quick-comment-or-uncomment-to-the-line
                                        ;"ll" 'evilnc-quick-comment-or-uncomment-to-the-line
                  "cc" 'evilnc-copy-and-comment-lines
                  "cp" 'evilnc-comment-or-uncomment-paragraphs
                  "cr" 'comment-or-uncomment-region
                  "cv" 'evilnc-toggle-invert-comment-line-by-line
                  "."  'evilnc-copy-and-comment-operator
                  "," 'evilnc-comment-operator ; if you prefer backslash key
                  ;; text related,
                  ;;1. spell.
                  ;; call selection window == mid click in gui
                  ;; "ss" 'flyspell-correct-word-before-point
                  "ss" 'flyspell-popup-correct
                  ;;
                  "sw" 'ispell-word
                  "sa" 'flyspell-buffer
                  "sf" 'flyspell-mode
                  "s SPC" 'flyspell-goto-next-error
                  ;; ein initiate command
                  "js" 'ein:jupyter-server-start
                  "jl" 'ein:notebooklist-login
                  "jo" 'ein:notebooklist-open
                  )

                ;; mode specific key-bindings
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
                  "gk" 'ein:worksheet-goto-prev-input))
      (evil-leader/set-key-for-mode 'org-mode
        "t"  'org-show-todo-tree
        "a"  'org-agenda
        "c"  'org-archive-subtree
        "j"  'org-metadown
        "h"  'org-metaleft
        "k"  'org-metaup
        "l"  'org-metaright
        ;; "l"  'evil-org-open-links
        ;; "o"  'evil-org-recompute-clocks
        )
      )
    (evil-mode 1))
  :config
  (progn
    ;; use ido to open files TODO: use ivy
    ;; (define-key evil-ex-map "e TAB" 'find-file)
    ;; (define-key evil-ex-map "sp TAB" 'find-file)
    ;; (define-key evil-ex-map "vsp " 'ido-find-file)
    ;; (define-key evil-ex-map "vsp TAB" 'find-file)
    ;; (define-key evil-ex-map "b TAB" 'switch-to-buffer)

    (setq
     ;; h/l wrap around to next lines
     evil-cross-lines t)

     ;; esc should always quit: http://stackoverflow.com/a/10166400/61435
     ;; (define-key evil-normal-state-map [escape] 'keyboard-quit)
     ;; (define-key evil-visual-state-map [escape] 'keyboard-quit)
     ;; (define-key minibuffer-local-map [escape] 'abort-recursive-edit)
     ;; (define-key minibuffer-local-ns-map [escape] 'abort-recursive-edit)
     ;; (define-key minibuffer-local-completion-map [escape] 'keyboard-quit)
     ;; (define-key minibuffer-local-must-match-map [escape] 'abort-recursive-edit)
     ;; (define-key minibuffer-local-isearch-map [escape] 'abort-recursive-edit)
    (define-key evil-normal-state-map [escape] 'keyboard-quit)
    (define-key evil-visual-state-map [escape] 'keyboard-quit)
    (define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
    (define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

     ;; modes to map to different default states
     (dolist (mode-map '((comint-mode . emacs)
                         (term-mode . emacs)
                         (eshell-mode . emacs)
                         (help-mode . emacs)
                         ))
       (evil-set-initial-state `,(car mode-map) `,(cdr mode-map)))))

(provide 'evil-init)
