{ lib, ... }:
{
  virtualisation.oci-containers.containers.qbittorrent = {
    image = "lscr.io/linuxserver/qbittorrent:5.2.4-libtorrentv1";
    networks = [ "host" ];
    
    environment = {
      DOCKER_MODS = "ghcr.io/vuetorrent/vuetorrent-lsio-mod:latest";
      PUID = "1000";
      PGID = "1000";
      WEBUI_PORT = "8081";
      TORRENTING_PORT = "54345";
    };

    volumes = [
      "/mnt/media/data/qbittorrent/appdata:/config"
      "/mnt/media/data/qbittorrent/downloads:/downloads"
    ];
  };

  networking.firewall.allowedTCPPorts = lib.mkForce [ 54345 ];
  networking.firewall.allowedUDPPorts = lib.mkForce [ 54345 ];
}
