{
  services.audiobookshelf = {
    enable = true;
    port = 8086;
    user = "main";
  };

  services.caddy.virtualHosts."mijn.domein.nl".extraConfig = ''
    reverse_proxy http://localhost:8086
  '';
}
