{ config, pkgs, ...}:
{
stylix = {
    enable = true;
    enableReleaseChecks = false;
    fonts = {
      serif.package = pkgs.nerd-fonts.daddy-time-mono;
      sansSerif.package = pkgs.nerd-fonts.daddy-time-mono;
      monospace.package = pkgs.nerd-fonts.daddy-time-mono;
      };
    image = ../../res/current_bg;
    cursor = {
      package = pkgs.banana-cursor;
      name = "Banana";
      size = 48;
    };
    polarity = "dark";
    opacity = {
      applications = 0.6;
      terminal = 0.6;
      desktop = 1.0;
      popups = 1.0;
    };
  };
}

