;; ============================================================
;; Starter Emacs Config — Claude Code on GitHub Codespaces
;; ============================================================
;; Place this file at: ~/.emacs.d/init.el
;; ============================================================


;; ------------------------------------------------------------
;; 1. PACKAGE MANAGER SETUP
;; ------------------------------------------------------------

(require 'package)
(setq package-archives
      '(("melpa"  . "https://melpa.org/packages/")
        ("gnu"    . "https://elpa.gnu.org/packages/")
        ("nongnu" . "https://elpa.nongnu.org/packages/")))
(package-initialize)

;; Bootstrap use-package (auto-installs packages)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
(setq use-package-always-ensure t) ;; auto-install all packages


;; ------------------------------------------------------------
;; 2. BASIC COMFORT SETTINGS
;; ------------------------------------------------------------

;; Clean up the UI
(menu-bar-mode -1)          ;; hide menu bar
(tool-bar-mode -1)          ;; hide tool bar
(scroll-bar-mode -1)        ;; hide scroll bar
(setq inhibit-startup-screen t) ;; skip welcome screen

;; Show line and column numbers
(global-display-line-numbers-mode t)
(column-number-mode t)

;; Highlight current line
(global-hl-line-mode t)

;; Show matching parentheses
(show-paren-mode t)

;; Auto-close brackets/quotes
(electric-pair-mode t)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;; Remember where you were in each file
(save-place-mode t)

;; Auto-reload files changed on disk
(global-auto-revert-mode t)

;; Bigger undo history
(setq undo-limit 80000)

;; Don't litter backup files everywhere
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-saves/" t)))


;; ------------------------------------------------------------
;; 3. THEME — easy on the eyes
;; ------------------------------------------------------------

(use-package doom-themes
  :config
  (load-theme 'doom-one t))      ;; dark theme, great contrast


;; ------------------------------------------------------------
;; 4. BETTER MINIBUFFER (makes M-x and file search nicer)
;; ------------------------------------------------------------

(use-package vertico
  :init (vertico-mode t))

(use-package orderless
  :custom
  (completion-styles '(orderless basic)))

(use-package marginalia
  :init (marginalia-mode t))     ;; shows descriptions next to commands


;; ------------------------------------------------------------
;; 5. WHICH-KEY — shows available keybindings as you type
;;    (very helpful when learning Emacs!)
;; ------------------------------------------------------------

(use-package which-key
  :init (which-key-mode t)
  :config
  (setq which-key-idle-delay 0.5))  ;; show after 0.5s


;; ------------------------------------------------------------
;; 6. FILE TREE SIDEBAR
;; ------------------------------------------------------------

(use-package treemacs
  :bind ("C-c t" . treemacs))   ;; C-c t toggles the sidebar


;; ------------------------------------------------------------
;; 7. SYNTAX HIGHLIGHTING — tree-sitter (modern, fast)
;; ------------------------------------------------------------

(use-package treesit-auto
  :config
  (global-treesit-auto-mode))


;; ------------------------------------------------------------
;; 8. TERMINAL EMULATOR — needed by claude-code.el
;; ------------------------------------------------------------

(use-package eat
  :ensure t)


;; ------------------------------------------------------------
;; 9. CLAUDE CODE INTEGRATION ⭐
;; ------------------------------------------------------------

(use-package claude-code
  :vc (:url "https://github.com/stevemolitor/claude-code.el" :rev :newest)
  :after eat
  :bind-keymap ("C-c c" . claude-code-command-map)
  :config (claude-code-mode))

;; Key bindings quick reference:
;;   C-c c c  — start Claude in current project
;;   C-c c r  — send selected region to Claude
;;   C-c c e  — fix error at cursor
;;   C-c c y  — say Yes to Claude
;;   C-c c n  — say No / cancel Claude action
;;   C-c c k  — kill Claude session
;;   C-c c m  — open full command menu


;; ------------------------------------------------------------
;; 10. HELPFUL GLOBAL KEYBINDINGS
;; ------------------------------------------------------------

;; Make Ctrl+Z undo (feels natural)
(global-set-key (kbd "C-z") 'undo)

;; Quick access to recent files
(recentf-mode t)
(global-set-key (kbd "C-c r") 'recentf-open-files)

;; Quick buffer switch
(global-set-key (kbd "C-c b") 'switch-to-buffer)


;; ------------------------------------------------------------
;; KEYBINDING CHEAT SHEET (beginners read this!)
;; ------------------------------------------------------------
;;
;; ESSENTIAL:
;;   C-x C-f    Open / find file
;;   C-x C-s    Save file
;;   C-x C-c    Quit Emacs
;;   C-x b      Switch buffer
;;   C-x k      Kill (close) buffer
;;   C-g        Cancel any command (your escape key!)
;;
;; EDITING:
;;   C-z        Undo
;;   C-space    Start selection
;;   M-w        Copy selection
;;   C-w        Cut selection
;;   C-y        Paste
;;
;; NAVIGATION:
;;   C-f / C-b  Move forward / backward one character
;;   M-f / M-b  Move forward / backward one word
;;   C-a / C-e  Go to start / end of line
;;   M-<        Go to top of file
;;   M->        Go to bottom of file
;;   C-s        Search forward (press again for next match)
;;
;; CLAUDE CODE:
;;   C-c c c    Start Claude
;;   C-c c r    Send region to Claude
;;   C-c c e    Fix error at cursor
;;   C-c c m    Command menu
;;
;; HELP:
;;   C-h t      Built-in Emacs tutorial (START HERE!)
;;   C-h k      Describe what a key does
;;   C-h f      Describe a function
;;   M-x        Run any command by name
;;
;; ============================================================
