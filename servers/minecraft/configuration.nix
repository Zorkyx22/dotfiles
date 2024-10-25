{ pkgs, modulesPath, inputs, ...}: {
   imports = [
      "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
      inputs.nix-minecraft.nixosModules.minecraft-servers
      ./services/kanata.nix
      ./services/tailscale.nix
      ./services/cloudflared.nix
      ./hardware/hardware-configuration.nix
      ./hardware/nvidia.nix
   ];
   nixpkgs.overlays = [inputs.nix-minecraft.overlay ];
   nixpkgs.hostPlatform = "x86_64-linux";
   boot.loader.systemd-boot.enable = true;
   boot.loader.efi.canTouchEfiVariables = true;
   system.stateVersion = "24.05";

   environment.systemPackages = with pkgs; [
      neovim
      git
      kanata
      cloudflared
   ];
   nix.settings.experimental-features = [ "nix-command" "flakes" ];

   time.timeZone = "America/Toronto";
   i18n.defaultLocale = "en_CA.UTF-8";
   nixpkgs = {
      config.allowUnfree=true;
   };

   networking = {
      hostName = "Hive";
      firewall.allowedTCPPorts = [ 3389 25565 ];
   };

   security.rtkit.enable = true;

   users.users.sire-n1chaulas = {
      isNormalUser = true;
      description = "Nicolas";
      extraGroups = [ "networkmanager" "wheel" "uinput" "input"];
      hashedPassword = "";
      openssh.authorizedKeys.keys = [
         "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP5nsIhvnGrkQqJ/TSxQSSA4VBQqczzhW4LpkcSNMLIM sire-n1chaulas@predator"
      ];
   };
 
   nix.settings.allowed-users = [ "sire-n1chaulas"];
   environment.sessionVariables = {
      WLR_NO_HARDWARE_CURSORS = "1";
      NIXOS_OZONE_WL = "1";
   };
   environment.localBinInPath = true;

   services = {
      openssh = {
         enable = true;
         settings.PasswordAuthentication = false;
      };
      printing.enable = false;
   };
}
