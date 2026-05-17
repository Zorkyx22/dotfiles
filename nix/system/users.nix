{ config, pkgs, ...}:
{
  users.users = {
    sire-n1chaulas = {
  	isNormalUser = true;
	description = "Nicolas";
	extraGroups = [ "networkmanager" "wheel" "uinput" "input" "docker" "plugdev" "adbusers" "audio" "dialout" "plugdev" "uucp" "lock" "libvirtd" "optical" "cdrom"];
	packages = with pkgs; [ 
	  gcc
	  nodejs
	  marksman
	  nixd
	  kanata
	  python313
	  typst
	  typst-live
	  makemkv
	  vlc
	  gimp
	  inkscape
	  audacity
	  claude-code
	  claude-monitor
	  felix-fm
	  bat
	  chafa
	  mediawriter
	  thunderbird
	  prismlauncher
	  openjdk25
	  signal-desktop
	  ghidra
	];
    };
  };
 
}

