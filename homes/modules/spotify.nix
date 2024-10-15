# Takes in spicetify-nix flake (github:Gerg-L/spicetify-nix/)
{ spicetify-nix, pkgs, ... }: {
  programs.spicetify.enable = true;
}
