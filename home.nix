{ pkgs, inputs, lib, config, options, specialArgs, modulesPath, nixosConfig, osConfig }: {
  home = {
    username = "main";
    homeDirectory = "/home/main";
    stateVersion = "24.05";
  };

  programs.git = import program-config/git.nix;

  programs.firefox = import program-config/firefox.nix { inherit pkgs inputs; };

  programs.home-manager.enable = true;
}
