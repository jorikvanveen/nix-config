{
  services.navidrome = {
    enable = true;
    settings.Port = 8089;
    settings.MusicFolder = "/mnt/media/music";
  };

  systemd.services.navidrome.serviceConfig.BindReadOnlyPaths = [
    "/mnt/media/data/qbittorrent/downloads"
  ];
}
