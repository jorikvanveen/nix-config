{ pkgs, ...} @ inputs: {
  home = {
    username = "main";
    homeDirectory = "/home/main";
    stateVersion = "24.05";
  };

  programs.git = {
    enable = true;
    userEmail = "vanveenjorik@protonmail.com";
    userName = "Jorik";
  };

  programs.firefox = {
    enable = true;
    profiles.default = {
      search.default = "DuckDuckGo";
      bookmarks = [
        {
          name = "Toolbar";
          toolbar = true;
          bookmarks = [
            {
              name = "Nix search";
              url = "https://search.nixos.org";
            }
          ];
        }
      ];
    };

  };

  programs.home-manager.enable = true;
}
