(use-modules
 (gnu)
 (gnu home)
 (gnu home services)
 (gnu home services desktop)
 (gnu home services dotfiles)
 (gnu home services fontutils)
 (gnu home services shells)
 (gnu home services sound)
 (gnu services)
 (gnu packages admin)
 (gnu packages librewolf)
 (gnu packages pulseaudio)
 (gnu packages emacs)
 (gnu packages fonts)
 (gnu packages terminals)

 (guix gexp)

 (nongnu packages fonts)) 

(home-environment
 (packages
  (append
   (list
    librewolf
    emacs-pgtk

    font-inter

 font-apple-symbols
 ;font-apple-sf-symbols
 font-apple-sf-pro
 font-apple-sf-mono
 font-apple-sf-compact
 font-apple-sf-arabic
 font-apple-new-york
 font-apple-color-emoji
    
    pavucontrol
    alacritty
    wvkbd
    tree)
   %base-packages))
 (services
  (append
   (list
    (service home-dbus-service-type)
    (service home-pipewire-service-type)
    (service home-dotfiles-service-type
      (home-dotfiles-configuration
        (directories '(".files"))
        (layout 'stow)
        (packages '("alacritty" "emacs" "eww" "hyprland"))))
    (simple-service
     'user-fontconfig-rules
     home-fontconfig-service-type
     (list
      '(alias (family "sans-serif") (prefer (family "SF Pro")))
      '(alias (family "monospace") (prefer (family "SF Mono")))
      '(alias (family "serif") (prefer (family "New York")))
      '(match (@ (target "font"))
	(edit (@ (name "antialias") (mode "assign")) (bool "true"))
	(edit (@ (name "hinting") (mode "assign")) (bool "false"))
	(edit (@ (name "lcdfilter") (mode "assign")) (const "lcdnone"))))))
        ;(test (@ (name "family") (compare "eq")) (string "Liberation Serif"))
         ;(edit (@ (name "embolden") (mode "assign")) (bool "true"))))))
      %base-home-services)))
