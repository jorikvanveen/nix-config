{ pkgs-stable, ... }: {
  services.radarr = {
    enable = true;
    package = pkgs-stable.radarr;
    user = "main";
    group = "users";
    dataDir = "/home/main/data/radarr";
  };
}
