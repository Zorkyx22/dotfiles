{ pkgs, ... }: {
    services.minecraft-servers = {
	enable = true;
	eula = true;

	servers = {
	    cool-server = {
		enable = true;
		package = pkgs.vanillaServers.vanilla-1_18_2;
	    };
	};
    };
}
