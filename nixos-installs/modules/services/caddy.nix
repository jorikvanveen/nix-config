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

        @plausible path /js/script.js /api/event
        handle @plausible {
          # Change this if you use a different variant of the script
          # e.g. rewrite /js/script.js /js/script.outbound-links.js
          rewrite /js/script.js /js/script.js
          reverse_proxy https://plausible.io {
            header_up Host {http.reverse_proxy.upstream.hostport}
          }
        }
      '';
      "plausible.jorik-dev.com".extraConfig =  ''
        reverse_proxy http://localhost:8087
      '';
      "rdt.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:6500
      '';
      "jackett.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:9117
      '';
    };
  };
}
