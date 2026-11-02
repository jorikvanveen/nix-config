{ config, ... }:
{
  sops.secrets.qui-session-secret = {
    restartUnits = [ "qui.service" ];
  };

  services.qui = {
    enable = true;
    user = "main";
    group = "users";
    secretFile = config.sops.secrets.qui-session-secret.path;
    settings = {
      host = "127.0.0.1";
      port = 7476;
      sessionCookieSecure = true;
      disableSelfUpdate = true;
    };
  };

  # Match the path qBittorrent reports from inside its container.
  systemd.services.qui = {
    serviceConfig.BindPaths = [ "/mnt/media/data/qbittorrent/downloads:/downloads" ];
  };
}
