{config, pkgs, ...}:
{
services.tailscale = {
    enable = true;
    openFirewall = true;
    useRoutingFeatures = "both";
  };
  boot.kernel.sysctl = {
    "net.ipv4.ip_forward"= 1;
    "net.ipv6.conf.all.forwarding" = 1;
  };
}
