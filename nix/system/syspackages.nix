{ config, pkgs, ...}:
{
environment.systemPackages = with pkgs; [  
      # Hardware Contols
      alsa-utils
      pavucontrol
      apulse
      bluez-alsa
      brightnessctl
      parted
      xorg.xhost
      gparted
      unetbootin
      ntfs3g
      nfs-utils

      # Core utilities
      ffmpeg
      nvtopPackages.nvidia
      stow
      qemu
      tree
      bat
      jq
      fzf
      zip
      unzip
      traceroute

      # Code Editing
      neovim
      git

      # Applications
      alacritty
      nautilus
      firefox
      zathura
      libreoffice

      # Hyprland stuff
      waybar
      dunst
      swww
      libnotify
      rofi
      rofi-rbw
      rofi-menugen
      rofi-calc
      networkmanagerapplet
      wl-clipboard
    #hyprshot
      hyprpolkitagent
      banana-cursor

      # VM stuff
      virt-manager
      virt-viewer
      virtio-win
      spice 
      spice-gtk
      spice-protocol
    ];
}
