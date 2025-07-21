This alone will not do much for emacs. You need to have emacs configured with an apply_theme function. I recommend using emacs --daemon and frames-only-mode
Currently my config for theming looks like this:

``` emacs-lisp
;;; themes.el -*- lexical-binding: t; -*-

;; opacity
(add-to-list 'default-frame-alist '(alpha-background . 72))

;; theme settings for default theme and switching themes

(defvar my:default-font "Monaspace Radon-15")
(defvar my:default-theme 'pink-bliss-uwu)

(defun apply-theme (theme-name font-name) (interactive)
  (setq my:theme theme-name)
  (setq my:font (concat font-name "-15"))
  (my:load-theme))

(defun my:load-theme ()
  (load-theme my:theme t)
  (setq doom-font my:font)
  (doom/reload-font))


;; TODO read theme from currently used theme?
(defvar my:font my:default-font)
(defvar my:theme my:default-theme)
(defvar my:theme-window-loaded nil)
(defvar my:theme-terminal-loaded nil)
(start-process "rand_theme" nil "nohup" "<insert_theming_directory_here>/random_theme.py" "1" "&")
;; some workaround for emacs --daemon being in terminal mode
(if (daemonp)
    (add-hook 'after-make-frame-functions(lambda (frame)
                       (select-frame frame)
                       (if (window-system frame)
                           (unless my:theme-window-loaded
                             (if my:theme-terminal-loaded
                                 (enable-theme my:theme)
                               (my:load-theme))
                             (setq my:theme-window-loaded t))
                         (unless my:theme-terminal-loaded
                           (if my:theme-window-loaded
                               (enable-theme my:theme)
                             (my:load-theme))
                           (setq my:theme-terminal-loaded t)))))

  (progn
    (my:load-theme)
    (if (display-graphic-p)
        (setq my:theme-window-loaded t)
      (setq my:theme-terminal-loaded t))))
```

Note that this has some problems when applying a color before (the first?) frame is opened. The problem can be resolved by manually calling

``` sh
emacsclient -e '(kill-emacs)'
emacs --daemon
```

When I get around to fix it, I will probably forget to update it here, so please remind me if you are interested.
