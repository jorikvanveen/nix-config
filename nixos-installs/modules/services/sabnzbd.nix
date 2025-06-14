{ pkgs, ... }: {
  services.sabnzbd = {
    package = pkgs.sabnzbd;
    enable = true;
    user = "main";
  };
}
