;; -*- mode: scheme; -*-
;; This is an operating system configuration template
;; for a "desktop" setup without full-blown desktop
;; environments.

(use-modules (gnu)
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

(use-service-modules desktop)
(use-package-modules bootloaders certs emacs wm xorg)

(operating-system
 (kernel linux)
 (initrd microcode-initrd)
 (firmware (list linux-firmware))
 
  (host-name "gnutopia")
  (timezone "America/Chicago")
  (locale "en_US.utf8")

  ;; Use the UEFI variant of GRUB with the EFI System
  ;; Partition mounted on /boot/esp.
  (bootloader (bootloader-configuration
                (bootloader grub-efi-bootloader)
                (targets '("/boot/esp"))))

  ;; Assume the target root file system is labelled "root",
  ;; and the EFI System Partition has UUID 1234-ABCD.
  (file-systems (append
                 (list (file-system
                         (device (file-system-label "root"))
                         (mount-point "/")
                         (type "btrfs")
                         (options "subvol=guix/rootfs"))
                       (file-system
                        (device (uuid "/dev/nvme0n1p1" 'fat))
                         (mount-point "/boot/esp")
                         (type "vfat")))
                 %base-file-systems))

  (users (cons (user-account
                (name "gnu-zi")
                (comment "GN/Uzi")
                (group "users")
                (supplementary-groups '("wheel" "netdev"
                                        "audio" "video")))
               %base-user-accounts))

  ;; Add a bunch of window managers; we can choose one at
  ;; the log-in screen with F1.
  (packages (append (list
                     ;; window managers
                     hyprland
                     ;; terminal programs
                     emacs git rsync
		     ;; graphical programs
		     icecat)
                    %base-packages))

  ;; Use the "desktop" services, which include the X11
  ;; log-in service, networking with NetworkManager, and more.
  (services (append (list
		     (service openssh-service-type)
                     (service gnome-desktop-service-type)))
                    %desktop-services))

  ;; Allow resolution of '.local' host names with mDNS.
  (name-service-switch %mdns-host-lookup-nss))
