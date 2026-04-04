{ pkgs, lib, ... }: {
  services.radarr = {
    enable = true;
    package = pkgs.radarr;
    user = "main";
    group = "users";
    dataDir = "/home/main/data/radarr";
  };

  systemd.services.radarr.serviceConfig = {
    ProtectHome = lib.mkForce false;
  };
}
