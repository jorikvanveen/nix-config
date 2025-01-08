{ pkgs-stable, ... }: {
  services.jackett.enable = true;
  services.jackett.user = "main";
  services.jackett.dataDir = "/home/main/data/jackett";
  services.jackett.package = pkgs-stable.jackett; # Unstable has build failure as of 8 jan 2025
}
