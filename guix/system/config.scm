;; -*- mode: scheme; -*-
(use-modules
 (gnu)
 (gnu system nss)
 (gnu services ssh)
 (gnu services xorg)
 (gnu services guix)
 (gnu packages window-management)
 (gnu packages version-control)
 (gnu packages rsync)
 (gnu packages gnuzilla)
 (guix channels)
 (nongnu packages linux)
 (nongnu system linux-initrd))

(use-service-modules
 desktop)
(use-package-modules
 bootloaders certs emacs xorg)

(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 
 (host-name "lgo")
 (timezone "Etc/GMT-8")
 (locale "en_US.utf8")
 
 (bootloader
  (bootloader-configuration
   (bootloader grub-efi-bootloader)
   (targets '("/boot/esp"))))
 
 (file-systems
  (append
   (list
    (file-system
     (mount-point "/")
     (device (file-system-label "root"))
     (type "btrfs")
     (options "subvol=guix/rootfs"))
    
    (file-system
     (mount-point "/home")
     (device (file-system-label "data"))
     (type "btrfs")
     (options "subvol=home"))

    (file-system
     (mount-point "/boot/esp")
     (device "/dev/nvme0n1p1")
     (type "vfat")))
   %base-file-systems))
 
 (swap-devices
  (list
   (swap-space
    (target
     (file-system-label "swap")))))
 (users
  (cons
   (user-account
    (name "user")
    (group "wheel")
    (uid 1001)
    (supplementary-groups
     '("netdev" "audio" "video")))
   %base-user-accounts))
 (packages
  (append
   (list
    emacs git rsync
    xterm twm icecat hyprland)
   %base-packages))
 (services
  (append
   (list
    (service openssh-service-type)
    (service gnome-desktop-service-type)
    (service startx-command-service-type)
    (simple-service 'nonguix-substitutes guix-service-type
     (guix-extension
      (substitute-urls '("https://substitutes.nonguix.org"))
      (authorized-keys
       (list
	(plain-file
	 "non-guix.pub"
	 "(public-key (ecc (curve Ed25519)
            (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)))"))))))
  %desktop-services)))
