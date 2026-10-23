{ pkgs, lib, ... }:
let
  cloudflare = import ../cloudflare-ips.nix;
  publicReverseProxy = upstream: ''
    reverse_proxy ${upstream} {
      import upstream-client-ip
    }
  '';
in
{
  networking.nftables.enable = true;
  networking.firewall.extraInputRules = ''
    ip saddr { ${lib.concatStringsSep ", " cloudflare.ipv4} } tcp dport { 80, 443 } accept comment "Cloudflare HTTP(S)"
    ip6 saddr { ${lib.concatStringsSep ", " cloudflare.ipv6} } tcp dport { 80, 443 } accept comment "Cloudflare HTTP(S)"
  '';

  services.caddy = {
    enable = true;
    package = pkgs.caddy;
    openFirewall = false;
    globalConfig = ''
      servers {
        trusted_proxies static ${lib.concatStringsSep " " (cloudflare.ipv4 ++ cloudflare.ipv6)}
        client_ip_headers CF-Connecting-IP
      }

      # Cloudflare terminates TLS, so use HTTP-01 through its proxy.
      # All hostnames need proxied public DNS, including WireGuard-only sites.
      # Cloudflare must forward /.well-known/acme-challenge/* to this origin.
      cert_issuer acme {
        disable_tlsalpn_challenge
      }
    '';
    extraConfig = ''
      # {client_ip} uses CF-Connecting-IP only when the peer is Cloudflare.
      # Replace incoming X-Forwarded-For instead of forwarding a spoofable chain.
      (upstream-client-ip) {
        header_up X-Forwarded-For {client_ip}
        header_up X-Real-IP {client_ip}
      }
    '';
    virtualHosts = {
      # Public services
      "seerr.jorik-dev.com".extraConfig = publicReverseProxy "http://localhost:47333";
      "j.jorik-dev.com".extraConfig = publicReverseProxy "http://localhost:8096";

      "vw.jorik-dev.com".extraConfig = publicReverseProxy "http://localhost:8222";

      "bitwarden.tobeqz-on.top".extraConfig = publicReverseProxy "http://localhost:8222";

      "atuin.jorik-dev.com".extraConfig = publicReverseProxy "http://localhost:8888";

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
            import upstream-client-ip
            header_up Host {http.reverse_proxy.upstream.hostport}
          }
        }
      '';

      # Private services: allow WireGuard clients and local loopback connections.
      # When changing access, also update the DNS records in ../wireguard.nix.
      "lr.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8686
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "s4k.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:9898
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "gonic.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:4747
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "navi.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8089
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "ab.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8086
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "hoarder.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:3131
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "ipfs.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8082
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "s.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8989
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "r.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:7878
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "p.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:9696
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "sab.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8080
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "nextcloud.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8900
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "llm.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8090
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "syncthing.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8384
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "sptr.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8383
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "plausible.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8087
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "rdt.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:6500
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "jackett.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:9117
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "qb.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8081 {
            header_up X-Real-IP {remote_host}
            header_up X-Forwarded-For {remote_host}
            header_up X-Forwarded-Proto {scheme}
            header_up X-Forwarded-Host {host}
          }
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "rq.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:5055
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "riven.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:3033
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "radicale.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:5232
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "calibre.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:8898
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "ebookdl.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:3300
          basic_auth {
            ebookdl $2y$05$SLaAYz9ufP0E/cBTnPL20.w0li9sO2WkxWTWbvsENiV6bcnTxK3K6
          }
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "wh.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:9000
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "actual.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:30313
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "hovyu-backend.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          root /srv/hovyu-static
          handle_path /static* {
            file_server
          }
          handle {
            reverse_proxy http://localhost:8000
          }
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "hovyu.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
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
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "platen.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          basic_auth {
            platen $2y$05$gpFloq5HzrH75yLFQEwZu.LXLTJMuDoXUP7SpPTYlCy05JH8bQv72
          }
          handle_path /api/* {
            reverse_proxy http://localhost:43330
          }
          reverse_proxy http://localhost:43331
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "oph-trainer.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://127.0.0.1:43332 {
            header_up X-Forwarded-For {remote_host}
          }
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "hermes.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:9119
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "matrix.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1 77.163.185.179
        handle @wireguard {
          reverse_proxy http://localhost:6167
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

      "ntfy.jorik-dev.com".extraConfig = ''
        @wireguard remote_ip 10.66.66.0/24 127.0.0.0/8 ::1
        handle @wireguard {
          reverse_proxy http://localhost:2586
        }
        handle {
          respond "Connect to WireGuard to access this service." 403
        }
      '';

    };
  };
}
