{
  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.nftables.enable = true;
  services.dnsmasq.enable = true;
}
