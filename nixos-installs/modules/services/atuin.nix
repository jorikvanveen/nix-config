{ pkgs, ... }: {
  services.atuin = {
    package = pkgs.atuin;
    enable = true;
    port = 8888;
    maxHistoryLength = 99999999999;
    database.createLocally = true;
    openRegistration = true;
  };
}
