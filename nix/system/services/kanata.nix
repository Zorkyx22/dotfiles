{config, pkgs, ...}:
{
services.kanata = {
    enable = true;
    keyboards = {
	internalKeyboard = {
	    devices = [
		"/dev/input/by-path/platform-i8042-serio-0-event-kbd"
	    ];
	    extraDefCfg = "process-unmapped-keys yes";
	    config = ''
		(defsrc caps alt)
		(defalias caps (tap-hold 200 200 esc lmet))
		(defalias altenter (tap-hold 200 200 enter alt))
		(deflayer Nichaud @caps @altenter)
	    '';
	};
    };
  };
}
