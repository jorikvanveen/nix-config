{ pkgs, homedir, dotfiledir, config, lib, ... }:
let
  stylixPalette = with config.lib.stylix.colors.withHashtag; ''
    require('mini.base16').setup({
      palette = {
        base00 = '${base00}', base01 = '${base01}', base02 = '${base02}', base03 = '${base03}',
        base04 = '${base04}', base05 = '${base05}', base06 = '${base06}', base07 = '${base07}',
        base08 = '${base08}', base09 = '${base09}', base0A = '${base0A}', base0B = '${base0B}',
        base0C = '${base0C}', base0D = '${base0D}', base0E = '${base0E}', base0F = '${base0F}'
      }
    })
  '';
in {
  stylix.targets.neovim.enable = lib.mkForce false;
  home.file.nvim-config = {
    target = homedir + "/.config/nvim/init.lua";
    source = config.lib.file.mkOutOfStoreSymlink dotfiledir + "/nvim/init.lua";
  };
  home.file.nvim-palette = {
    target = homedir + "/.config/nvim/lua/palette.lua";
    text = stylixPalette;
  };
  home.packages = [
    (pkgs.neovim.override {
      configure.packages.myPlugins.start = pkgs.callPackage ../../program-config/neovim/plugins.nix { };
      configure.customRC = "source /home/main/.config/nvim/init.lua";
    })
  ];
}
