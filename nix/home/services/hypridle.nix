{config, pkgs, ...}:
{
  services.hypridle = {
    enable = true;
    settings = {
     general = {
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
        lock_cmd = "hyprlock";
      };
    listener = [
        {
          timeout = 300;
          on-timeout = "hyprlock";
        }
        {
          timeout = 900;
          on-timeout = "hyprctl dispatch dmps off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
