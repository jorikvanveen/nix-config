{
  services.gonic = {
    enable = true;
    settings = {
      music-path = [
        "/mnt/media/music"
      ];
      playlists-path = [
        "/mnt/media/data/gonic-playlists"
      ];
      podcast-path = [
        "/mnt/media/podcasts"
      ];
      listen-addr = "127.0.0.1:4747";
      scan-watcher-enabled = true;
    };
  };
  systemd.services.gonic.serviceConfig.BindReadOnlyPaths = [
    "/mnt/media/data/qbittorrent/downloads"
  ];
}
