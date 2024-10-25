{config, pkgs, ...}:
{
services.kanata = {
    enable = true;
    keyboards = {
	internalKeyboard = {
	    devices = [
		"/dev/input/by-id/usb-SINO_WEALTH_Bluetooth_Keyboard-event-kbd"
	    ];
	    extraDefCfg = "process-unmapped-keys yes";
	    config = ''
		(defsrc caps )
		(defalias caps (tap-hold 200 200 esc lmet))
		(deflayer Nichaud @caps )
	    '';
	};
    };
  };
}
