{ pkgs, ... }: {
  services.jackett.enable = true;
  services.jackett.user = "main";
  services.jackett.dataDir = "/home/main/data/jackett";
  services.jackett.package = pkgs.jackett;
}
