{ pkgs-stable, ... }: {
  services.atuin = {
    package = pkgs-stable.atuin;
    enable = true;
    port = 8888;
    maxHistoryLength = 99999999999;
    database.createLocally = true;
    openRegistration = true;
  };
}
