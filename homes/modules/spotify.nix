# Takes in spicetify-nix flake (github:Gerg-L/spicetify-nix/)
{ spicetify, pkgs, ... }: let
  spicePkgs = spicetify.legacyPackages.x86_64-linux;
in {
  imports = [
    spicetify.homeManagerModules.default
  ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = [
      spicePkgs.shuffle # Shuffle+
    ];
  };

  home.packages = [
    pkgs.spotify
  ];
}
