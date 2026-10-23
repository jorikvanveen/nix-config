{ lib, pkgs, ... }:
{
  networking.wireguard.interfaces.wg0 = {
    ips = [ "10.66.66.1/24" ];
    listenPort = 51820;
    privateKeyFile = "/var/lib/wireguard/private-key";
    generatePrivateKeyFile = true;
    peers = import ./wireguard-peers.nix;
  };

  environment.systemPackages = [ pkgs.wireguard-tools ];

  # Allow HTTP(S), WireGuard, and mDNS discovery. Services can
  # explicitly add public ports with allowedTCPPorts/allowedUDPPorts = mkForce.
  networking.firewall = {
    # Bootstrap: remove 22 after verifying a fresh SSH session to 10.66.66.1.
    allowedTCPPorts = lib.mkForce [ 22 80 443 ];
    allowedUDPPorts = lib.mkForce [ 443 5353 51820 ];
    interfaces.wg0 = {
      allowedTCPPorts = [ 22 53 80 443 22000 25565 ];
      allowedUDPPorts = [ 53 443 22000 25565 ];
    };
  };

  # Clients use this resolver so private hostnames travel through the tunnel.
  # Public hostnames retain their normal public DNS records.
  services.dnsmasq = {
    enable = true;
    resolveLocalQueries = false;
    settings = {
      interface = "wg0";
      listen-address = "10.66.66.1";
      bind-dynamic = true;
      no-hosts = true;
      no-resolv = true;
      server = [ "1.1.1.1" "1.0.0.1" ];
      host-record = [
        "lr.jorik-dev.com,10.66.66.1"
        "s4k.jorik-dev.com,10.66.66.1"
        "gonic.jorik-dev.com,10.66.66.1"
        "navi.jorik-dev.com,10.66.66.1"
        "ab.jorik-dev.com,10.66.66.1"
        "hoarder.jorik-dev.com,10.66.66.1"
        "ipfs.jorik-dev.com,10.66.66.1"
        "s.jorik-dev.com,10.66.66.1"
        "r.jorik-dev.com,10.66.66.1"
        "p.jorik-dev.com,10.66.66.1"
        "sab.jorik-dev.com,10.66.66.1"
        "nextcloud.jorik-dev.com,10.66.66.1"
        "llm.jorik-dev.com,10.66.66.1"
        "syncthing.jorik-dev.com,10.66.66.1"
        "sptr.jorik-dev.com,10.66.66.1"
        "plausible.jorik-dev.com,10.66.66.1"
        "rdt.jorik-dev.com,10.66.66.1"
        "jackett.jorik-dev.com,10.66.66.1"
        "qb.jorik-dev.com,10.66.66.1"
        "rq.jorik-dev.com,10.66.66.1"
        "riven.jorik-dev.com,10.66.66.1"
        "radicale.jorik-dev.com,10.66.66.1"
        "calibre.jorik-dev.com,10.66.66.1"
        "ebookdl.jorik-dev.com,10.66.66.1"
        "wh.jorik-dev.com,10.66.66.1"
        "actual.jorik-dev.com,10.66.66.1"
        "hovyu-backend.jorik-dev.com,10.66.66.1"
        "hovyu.jorik-dev.com,10.66.66.1"
        "platen.jorik-dev.com,10.66.66.1"
        "oph-trainer.jorik-dev.com,10.66.66.1"
        "hermes.jorik-dev.com,10.66.66.1"
        "matrix.jorik-dev.com,10.66.66.1"
        "ntfy.jorik-dev.com,10.66.66.1"
      ];
      # Do not forward AAAA queries for private names to public DNS.
      local = [
        "/lr.jorik-dev.com/"
        "/s4k.jorik-dev.com/"
        "/gonic.jorik-dev.com/"
        "/navi.jorik-dev.com/"
        "/ab.jorik-dev.com/"
        "/hoarder.jorik-dev.com/"
        "/ipfs.jorik-dev.com/"
        "/s.jorik-dev.com/"
        "/r.jorik-dev.com/"
        "/p.jorik-dev.com/"
        "/sab.jorik-dev.com/"
        "/nextcloud.jorik-dev.com/"
        "/llm.jorik-dev.com/"
        "/syncthing.jorik-dev.com/"
        "/sptr.jorik-dev.com/"
        "/plausible.jorik-dev.com/"
        "/rdt.jorik-dev.com/"
        "/jackett.jorik-dev.com/"
        "/qb.jorik-dev.com/"
        "/rq.jorik-dev.com/"
        "/riven.jorik-dev.com/"
        "/radicale.jorik-dev.com/"
        "/calibre.jorik-dev.com/"
        "/ebookdl.jorik-dev.com/"
        "/wh.jorik-dev.com/"
        "/actual.jorik-dev.com/"
        "/hovyu-backend.jorik-dev.com/"
        "/hovyu.jorik-dev.com/"
        "/platen.jorik-dev.com/"
        "/oph-trainer.jorik-dev.com/"
        "/hermes.jorik-dev.com/"
        "/matrix.jorik-dev.com/"
        "/ntfy.jorik-dev.com/"
      ];
    };
  };

  # Syncthing relays would otherwise allow access without the VPN.
  services.syncthing.settings.options = {
    relaysEnabled = lib.mkForce false;
    globalAnnounceEnabled = false;
    localAnnounceEnabled = false;
  };
}
