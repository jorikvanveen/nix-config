{ pkgs-stable, ... }: {
  services.prowlarr = {
    enable = true;
    package = pkgs-stable.prowlarr;
  };
}
