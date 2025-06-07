{ pkgs, ... }:
(pkgs.neovim.override {
  configure.packages.myPlugins.start = pkgs.callPackage ./plugins.nix { };
  configure.customRC = "source ${../../dotfiles/nvim/init.lua}";
})
