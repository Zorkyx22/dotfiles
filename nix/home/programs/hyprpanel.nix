{ inputs, pkgs, ... }:
{
  programs.hyprpanel = {
    enable = true;
    settings = {
      menus.clock = {
        time = {
          military = true;
          hideSeconds = true;
        };
        weather.unit = "metric";
      };
      theme.font = {
        name = "DaddyTimeMono";
        size = "14px";
      };
    };
  };
}
