{ inputs, system, ... }:
  let pkgs = import inputs.nixpkgs-stable { inherit system; };
in {
  nix.package = pkgs.lix; # broken on unstable as of 15 Sep 2pkgs025
}
