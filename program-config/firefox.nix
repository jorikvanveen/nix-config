{ inputs }: {
  enable = true;
  profiles.default = {
    search.force = true;
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
      "middleclick.paste" = false;
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

  }
