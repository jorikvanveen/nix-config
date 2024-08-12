{ pkgs, inputs, lib, config, options, specialArgs, modulesPath, nixosConfig, osConfig }: {
  programs.home-manager.enable = true;

  home = {
    username = "main";
    homeDirectory = "/home/main";
    stateVersion = "24.05";
    shellAliases = {
      "zed" = "nix-shell ~/Projects/zed-nix/shell.nix";
    };

    file.zed = {
      enable = true;
      source = program-config/zed;
      recursive = true;
    };
  };

  programs.git = import program-config/git.nix;
  programs.firefox = import program-config/firefox.nix { inherit inputs; };

  dconf.settings = import ./dconf.nix { inherit lib; };
}
