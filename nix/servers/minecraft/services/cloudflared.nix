{ ... }: {
    services.cloudflared = {
	enable = true;
	tunnels = {};
    };
}
