{ pkgs, inputs, lib, config, options, specialArgs, modulesPath, nixosConfig, osConfig }:
  let homedir = "/home/main";
in {
  _module.args = { inherit homedir; };
  imports = [
    ./generic.nix
    ./modules/zed-node-fix.nix
    ./modules/mime-associations.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "main";
    homeDirectory = homedir;
    stateVersion = "24.05";
  };

  dconf.settings = import ../dconf.nix { inherit lib; };
}