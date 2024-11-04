# Takes the stylix flake (github:danth/stylix)
{ inputs, pkgs, ... }: let
  sfmono = inputs.apple-fonts.packages.x86_64-linux.sf-mono-nerd;
  sfpro = inputs.apple-fonts.packages.x86_64-linux.sf-pro;
  ny = inputs.apple-fonts.packages.x86_64-linux.ny;
in {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = ./.bg.jpg;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Classic";
  stylix.polarity = "dark";
  stylix.cursor.size = 24;
  stylix.fonts.monospace = {
    name = "SFMono Nerd Font";
    package = sfmono;
  };
  stylix.fonts.sansSerif = {
    name = "SF Pro";
    package = sfpro;
  };
  stylix.fonts.sizes = {
    desktop = 11;
    applications = 11;
    terminal = 11;
  };
}
