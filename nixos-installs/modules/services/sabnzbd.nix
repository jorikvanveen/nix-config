{ pkgs-stable, ... }: {
  services.sabnzbd = {
    package = pkgs-stable.sabnzbd;
    enable = true;
    user = "main";
  };
}
