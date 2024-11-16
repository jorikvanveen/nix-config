{
  programs.atuin = {
    enable = true;
    enableNushellIntegration = true;
    enableBashIntegration = false;
    settings = {
      auto_sync = true;
      sync_frequency = "5m";
      sync_address = "https://atuin.jorik-dev.com";
      search_mode = "fuzzy";
    };
  };
}
