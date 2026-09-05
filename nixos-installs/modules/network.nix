{
  networking.networkmanager.enable = true;
  services.dnsmasq = {
    enable = true;
    settings = {
      listen-address = "127.0.0.1";
      bind-interfaces = true;
      no-resolv = true;
      server = [ "1.1.1.1" "1.0.0.1" ];
    };
  };
}
