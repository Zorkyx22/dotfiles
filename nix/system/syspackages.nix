{ config, pkgs, ...}:
{ environment.systemPackages = with pkgs; [  
      # Hardware Contols
      alsa-utils
      pavucontrol
      pulseaudio
      apulse
      bluez-alsa
      brightnessctl
      parted
      xorg.xhost
      xwayland-satellite
      gparted
      unetbootin
      ntfs3g
      nfs-utils
      android-tools

      # Core utilities
      ffmpeg
      nvtopPackages.nvidia
      stow
      qemu
      tree
      jq
      fd
      fzf
      zip
      unzip
      traceroute
      hplip

      # Code Editing
      neovim
      git

      # language servers
      nil
      lua-language-server
      rust-analyzer
      zls
      ty
      tinymist
      marksman

      # Linters
      alejandra
      ruff

      # Applications
      alacritty
      nautilus
      firefox
      zathura
      libreoffice

      # Hyprland stuff
      waybar
      quickshell
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
