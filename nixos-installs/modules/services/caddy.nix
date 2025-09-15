{ pkgs, ... }:
{
  services.caddy = {
    enable = true;
    package = pkgs.caddy;
    virtualHosts = {
      "lr.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8686
      '';
      "s4k.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:9898
      '';
      "gonic.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:4747
      '';
      "navi.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8089
      '';
      "ab.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8086
      '';
      "hoarder.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:3131
      '';
      "ipfs.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8082
      '';
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
      "sptr.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8383
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
      "plausible.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8087
      '';
      "rdt.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:6500
      '';
      "jackett.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:9117
      '';
      "qb.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8081
      '';
      "rq.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:5055
      '';
      "riven.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:3033
      '';
      "vw.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8222
      '';
      "bitwarden.tobeqz-on.top".extraConfig = ''
        reverse_proxy http://localhost:8222
      '';
      "radicale.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:5232
      '';
      "calibre.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:8898
      '';
      "ebookdl.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:3300
        basic_auth {
          ebookdl $2y$05$SLaAYz9ufP0E/cBTnPL20.w0li9sO2WkxWTWbvsENiV6bcnTxK3K6
        }
      '';
      "wh.jorik-dev.com".extraConfig = ''
        reverse_proxy http://localhost:9000
      '';
      "hovyu-backend.jorik-dev.com".extraConfig = ''
        handle /static {
          root * /srv/hovyu-static/
          file_server
          encode gzip
        }
        handle {
          reverse_proxy http://localhost:8000
        }
      '';
      "hovyu.jorik-dev.com".extraConfig = ''
        root * /srv/hovyu-frontend
        try_files {path} /index.html
        file_server
        encode gzip

        # Strict security headers for production
        header {
            Strict-Transport-Security "max-age=63072000; includeSubDomains; preload"
            X-Content-Type-Options nosniff
            X-Frame-Options DENY
            X-XSS-Protection "1; mode=block"
            Referrer-Policy strict-origin-when-cross-origin
        }
      '';
    };
  };
}
