{ lib, ... }:
{
  imports = [ ./torrent-network.nix ];

  virtualisation.oci-containers.containers.qbittorrent = {
    image = "lscr.io/linuxserver/qbittorrent:5.2.4-libtorrentv1";
    networks = [ "torrenting" ];
    
    environment = {
      DOCKER_MODS = "ghcr.io/vuetorrent/vuetorrent-lsio-mod:latest";
      PUID = "1000";
      PGID = "1000";
      # Match the published port for qBittorrent's Host header validation.
      WEBUI_PORT = "8081";
      TORRENTING_PORT = "54345";
    };

    volumes = [
      "/mnt/media/data/qbittorrent/appdata:/config"
      "/mnt/media/data/qbittorrent/downloads:/downloads"
    ];

    ports = [
      "127.0.0.1:8081:8081"
      "54345:54345"
      "54345:54345/udp"
    ];
  };

  systemd.services.docker-qbittorrent = {
    requires = [ "docker-network-torrenting.service" ];
    after = [ "docker-network-torrenting.service" ];
  };

  networking.firewall.allowedTCPPorts = lib.mkForce [ 54345 ];
  networking.firewall.allowedUDPPorts = lib.mkForce [ 54345 ];
}
