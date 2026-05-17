{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware/hardware-configuration.nix 
      ./hardware/nvidia.nix
      ./stylix.nix
      ./services/tailscale.nix
      ./services/kanata.nix
      ./syspackages.nix
      ./users.nix
    ]; # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  system.stateVersion = "24.05";
  nix.settings.experimental-features = ["nix-command" "flakes"];
  time.timeZone = "America/Toronto";
  i18n.defaultLocale = "en_CA.UTF-8";
  nixpkgs = {
    config.allowUnfree=true;
    config.allowBroken=true; }; networking = {
    hostName = "worker";
    networkmanager.enable = true;
    firewall.allowedTCPPorts = [ 3389 ];#8081 3000 ];
  };
  services.resolved.enable = true;

  security.rtkit.enable = true;
  security.pam.services.hyprlock = {};

  nix.settings.allowed-users = [ "sire-n1chaulas"];
  users.groups.libvirtd.members = ["sire-n1chaulas"];

  fonts.packages = with pkgs; [
      nerd-fonts.daddy-time-mono
      nerd-fonts.profont
      nerd-fonts.symbols-only
    ];

  boot.initrd = {
    supportedFilesystems = [ "nfs" ];
    kernelModules = [ "nfs" ];
  };

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };
  services = {
    hardware.bolt.enable = true;
    samba = {
      enable = true;
      package = pkgs.samba4Full;
      openFirewall = true;
    };
    udev.packages = [ 
      pkgs.platformio-core.udev
    ];
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
    displayManager.gdm = {
      enable = true;
      wayland = true;
    };

    pulseaudio = {
      enable = false;
      support32Bit = true;
    };
    pipewire.enable = true;
    gnome.sushi.enable = true;

  };
  programs = {
    hyprland = {
      enable = false;
      xwayland.enable = true;
    };
    niri.enable = true;
    localsend =  {
      enable=true;
      openFirewall = true;
    };
    virt-manager.enable = true;
    ghidra.enable = true;
    obs-studio.enable = true;
    steam = {
      enable =true;
      package = pkgs.steam.override {
        extraArgs = "-system-composer";
      };
    };
  };

  virtualisation = {
    docker.enable = true;
    libvirtd.enable = true;
    spiceUSBRedirection.enable = true;
  };

  environment = {
   localBinInPath = true;
    variables = {
      EDITOR = "nvim";
    };
    sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
    };
  };
}
