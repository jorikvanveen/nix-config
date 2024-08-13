{ pkgs, inputs, lib, config, options, specialArgs, modulesPath, nixosConfig, osConfig }: {
  programs.home-manager.enable = true;

  home = let home = "/home/main"; in {
    username = "main";
    homeDirectory = home;
    stateVersion = "24.05";

    file.zed = {
      enable = true;
      source = program-config/zed;
      target = home + "/.config/zed";
      recursive = true;
    };
  };

  programs.git = import program-config/git.nix;
  programs.firefox = import program-config/firefox.nix { inherit inputs; };

  programs.carapace.enable = true;
  programs.carapace.enableNushellIntegration = true;
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;
      # character = {

      # };
    };
  };

  programs.nushell = {
    enable = true;
    configFile.source = program-config/nushell/config.nu;
  };
  
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    nix-direnv.enable = true;
  };

  programs.bash.enable = true;


  dconf.settings = import ./dconf.nix { inherit lib; };
}
