# Takes the stylix flake (github:danth/stylix)
{ stylix, pkgs, apple-fonts, ... }: let
  sfmono = apple-fonts.packages.x86_64-linux.sf-mono-nerd;
  sfpro = apple-fonts.packages.x86_64-linux.sf-pro;
  ny = apple-fonts.packages.x86_64-linux.ny;
in {
  imports = [
    stylix.nixosModules.stylix
  ];

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = ./.bg.jpg;
  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Classic";
  stylix.polarity = "dark";
  stylix.cursor.size = 24;
  #stylix.fonts.packages = [
  #  sfmono
  #  sfpro
  #  ny
  #];
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