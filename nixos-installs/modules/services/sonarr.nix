{ pkgs-stable, ... }: {
  services.sonarr = {
    enable = true;
    package = pkgs-stable.sonarr;
    user = "main";
    group = "users";
    dataDir = "/home/main/data/sonarr";
  };
}
