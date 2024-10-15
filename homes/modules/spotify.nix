# Takes in spicetify-nix flake (github:Gerg-L/spicetify-nix/)
{ spicetify-nix, pkgs, ... }: let
  spicePkgs = spicetify-nix.legacyPackages.x86_64-linux;
in {
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
