{ pkgs-stable, ... }: {
  services.caddy = {
    enable = true;
    package = pkgs-stable.caddy;
    virtualHosts = {
      "j.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8096
      '';
      "s.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8989
      '';
      "r.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:7878
      '';
      "p.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:9696
      '';
      "sab.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8080
      '';
      "nextcloud.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8900
      '';
      "llm.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8090
      '';
      "atuin.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8888
      '';
      "syncthing.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8384
      '';
      "tutorials.jorik-dev.com".extraConfig = ''
        encode gzip
        root * /srv/tutorials
        file_server
      '';
      "plausible.jorik-dev.com".extraConfig =  ''
        reverse_proxy http://localhost:8087
      '';
    };
  };
}
