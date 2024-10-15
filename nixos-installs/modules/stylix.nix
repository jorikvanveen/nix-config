# Takes the stylix flake (github:danth/stylix)
{ stylix, pkgs, ... }: {
  imports = [
    stylix.nixosModules.stylix
  ];

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
  stylix.image = ./.bg.jpg;
}
