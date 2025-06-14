{ pkgs, ... }: {
  services.radarr = {
    enable = true;
    package = pkgs.radarr;
    user = "main";
    group = "users";
    dataDir = "/home/main/data/radarr";
  };
}
