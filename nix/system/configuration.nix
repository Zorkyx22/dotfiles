{ pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/hardware-configuration.nix
      ./hardware/nvidia.nix
      ./services/tailscale.nix
      ./services/kanata.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.05";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  nixpkgs = {
    config.allowUnfree=true;
    config.allowBroken=true;
  };

  networking = {
    hostName = "predator";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 3389 ];
  };

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;

  users.users.sire-n1chaulas = {
  	isNormalUser = true;
	description = "Nicolas";
	extraGroups = [ "networkmanager" "wheel" "uinput" "input"];
	packages = with pkgs; [
	  kdePackages.kate
	  kanata
	  python313
	  banana-cursor
	];
  };
 
 nix.settings.allowed-users = [ "sire-n1chaulas"];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment = {
    systemPackages = with pkgs; [  
      neovim
      git
      gcc
      firefox
      ffmpeg
      vesktop
      nixd
      prismlauncher
      nvtopPackages.nvidia
      stow
      # Hyprland stuff
      waybar
      dunst
      libnotify
      kitty 
      rofi-wayland
      rofi-rbw
      rofi-menugen
      rofi-calc
      networkmanagerapplet
      swww
      nautilus
      # End Hyprland stuff
    ];
    localBinInPath = true;
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
 
  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };

    xserver = {
      enable=true;
      xkb = {
        layout="us";
        variant="";
      };
    };

    displayManager.sddm = {
      enable=true;
      wayland= {
        enable=true;
      };
    };
    #desktopManager.plasma6.enable=true;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    
    # Disable CUPS to print documents. CVE 2024-something something
    printing.enable = false;
    gnome.sushi.enable = true;

  };
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  programs.steam.enable = true;
  stylix.base16Scheme = {
    base00= "303446"; # base
    base01= "292c3c"; # mantle
    base02= "414559"; # surface0;
    base03= "51576d"; # surface1;
    base04= "626880"; # surface2;
    base05= "c6d0f5"; # text;
    base06= "f2d5cf"; # rosewater;
    base07= "babbf1"; # lavender;
    base08= "e78284"; # red;
    base09= "ef9f76"; # peach;
    base0A= "e5c890"; # yellow;
    base0B= "a6d189"; # green;
    base0C= "81c8be"; # teal;
    base0D= "8caaee"; # blue;
    base0E= "ca9ee6"; # mauve;
    base0F= "eebebe"; # flamingo;
  };
  stylix.image = "~/Pictures/backgrounds/lock.png";
  stylix.cursor = {
    package = pkgs.banana-cursor;
    name = "Banana";
  };
  stylix.polarity = "dark";
  stylix.opacity = {
    applications = 0.6;
    terminal = 0.6;
    desktop = 1.0;
    popups = 1.0;
  };
}
