{ pkgs, inputs, lib, config, options, specialArgs, modulesPath, nixosConfig, osConfig }: {
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
      extensions = with inputs.ff-addons.packages.x86_64-linux; [
        ublock-origin
        bitwarden
        tree-style-tab
      ];
      settings = {
        "signon.rememberSignons" = false;
        "app.shield.optoutstudies.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
      };
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
