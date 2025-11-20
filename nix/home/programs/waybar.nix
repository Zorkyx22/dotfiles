{ config, ...}:
{
  programs.waybar = {
    enable = true;
    settings = {
      mainBar = {
        layer = "top";
        position = "top";
        height = 24;
        spacing = 5;
        modules-left = ["hyprland/workspaces"]; modules-center = ["clock"]; modules-right = ["cpu" "memory" "pulseaudio" "network" "bluetooth" "battery"]; cpu = { 
          interval = 10; 
          format = "CPU: {usage}%" ;
        };
        memory = { 
          interval = 30; 
          format = "RAM: {percentage}%" ;
        };
        clock = {
          tooltip-format = "{calendar}";
          format-alt = "  {:%a, %d %b %Y}";
          format = "{:%H:%M}";
        };
        pulseaudio = {
          format = "{volume}% {icon}";
          format-bluetooth = "󰂰";
          nospacing = 1;
          tooltip-format = "Volume : {volume}%";
          format-muted = "󰝟";
          format-icons = {
            headphone = "";
            default = ["󰖀" "󰕾" ""];
          };
          on-click = "pavucontrol";
          scroll-step = 1;
          };
        network = {
          format  = "󰤨";
          format-wifi  = "{icon}";
          format-icons = ["󰤯" "󰤟" "󰤥" "󰤨"];
          format-ethernet = "󰀂";
          format-disconnected  = "󰖪";
	  tooltip-format-wifi = "{icon} {essid}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
          tooltip-format-ethernet = "󰀂  {ifname}\n⇣{bandwidthDownBytes}  ⇡{bandwidthUpBytes}";
	  tooltip-format-disconnected = "Disconnected";
	  on-click = "~/.config/rofi.sire-n1chaulas/scripts/wifi.sh &";
        };
        battery = {
          format = "{icon} {capacity}% - {time}";
          format-icons = ["" "" "" "" ""];
          format-time = "{H}h{M}m";
          format-charging = " {icon}";
          format-full = " {icon}";
          interval = 30;
          states = {
            warning = 25;
            critical = 10;
          };
          tooltip = false;
          on-click = "~/.config/rofi/powermenu/type-1/powermenu.sh &";
        };
      };
    };
 style = ''
      * {
        border: none; min-height: 0;
        font-family: DaddyTimeMono Nerd Font;
        font-size: 16px;
        border-radius: 15px;
      }
      
      window#waybar {
        background-color: transparent;
        transition-property: background-color;
        transition-duration: 0.5s;
      }
      
      #workspaces {
        background-color: transparent;
      }
      
      #workspaces button {
        all: initial;
        min-width: 0;
        box-shadow: inset 0 -3px transparent;
        padding: 3px 10px;
        margin: 10px;
        border-radius: 16px;
        background-color: #1e1e2e;
        color: #cdd6f4;
      }
      
      #workspaces button.active {
        background-color: #1e1e2e;
        color: #cdd6f4;
      }
      
      #workspaces button:hover {
        box-shadow: inherit;
        text-shadow: inherit;
        background-color: #1e1e2e;
        color: #cdd6f4;
      }
      
      #workspaces button.urgent {
        background-color: #f38ba8;
      }
      
      #cpu,
      #idle_inhibitor,
      #memory,
      #pulseaudio,
      #clock,
      #network,
      #battery {
        margin: 6px 3px;
        padding: 6px 12px;
        color: #181825;
      }
      
      #network {
        padding-right: 17px;
      }
      
      #memory {
      }
      
      #pulseaudio {
        padding-right: 17px;
      }
      
      #clock {
        font-family: DaddyTimeMono Nerd Font;
      }
      
      #cpu {
      }
      
      #battery {
        margin-right: 10px;
      }
      

      tooltip {
        border-radius: 8px;
        padding: 15px;
      }
      
      tooltip label {
        padding: 5px;
      }'';
  };
}  
