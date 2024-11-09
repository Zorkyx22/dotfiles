{config, pkgs, inputs, ...}:

{
  imports = [
    ./programs/git.nix
    ./programs/tmux.nix
    ./programs/nvim.nix
    ./programs/zoxide.nix
    ./programs/zsh.nix
    ./programs/firefox.nix
    ./programs/hyprlock.nix
    ./services/hypridle.nix
  ];

  home.username = "sire-n1chaulas";
  home.homeDirectory = "/home/sire-n1chaulas";

  nixpkgs.config.allowUnfree = true;
  home.stateVersion = "24.05";
  fonts.fontconfig.enable = true;

  home.packages = with pkgs; [
    discord
    bitwarden
    xclip
    wine
    #fonts begin
    nerdfonts
    font-awesome
    #fonts end
  ];

  programs = {
    home-manager.enable = true;
    btop.enable = true;
    ripgrep.enable = true;
    pandoc.enable = true;
  };

  gtk = {
    enable = true;
    theme = {
      package = pkgs.banana-cursor;
      name = "Banana";
    };
  };

  home.pointerCursor = {
    x11.enable = true;
    gtk.enable = true;
    name = "Banana";
    size = 48;
    package = pkgs.banana-cursor;
  };
}
