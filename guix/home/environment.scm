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
 (gnu packages terminals)

 (guix gexp))

(home-environment
 (packages
  (append
   (list
    librewolf
    emacs-pgtk

    ;font-inter
    
    pavucontrol
    alacritty
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
        (packages '("alacritty" "emacs" "eww" "hypr"))))
    (simple-service
     'user-fontconfig-rules
     home-fontconfig-service-type
     (list
      '(alias (family "sans-serif") (prefer (family "Forma DJR Text")))
      '(alias (family "monospace") (prefer (family "Forma DJR Mono")))
      '(alias (family "serif") (prefer (family "Liberation Serif")))
      '(match (@ (target "font"))
	(edit (@ (name "antialias") (mode "assign")) (bool "true"))
	(edit (@ (name "hinting") (mode "assign")) (bool "false"))
	(edit (@ (name "lcdfilter") (mode "assign")) (const "lcdnone"))
        (test (@ (name "family") (compare "eq")) (string "Liberation Serif"))
         (edit (@ (name "embolden") (mode "assign")) (bool "true"))))))
      %base-home-services)))
