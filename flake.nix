{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs_stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs_stable";
  };

  outputs = { self, nixpkgs, nixpkgs_stable, ... } @ inputs:
  let
    unstable = nixpkgs.legacyPackages.x86_64-linux;
    pkgs = nixpkgs_stable.legacyPackages.x86_64-linux;
  in
  {
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [
        ./configuration.nix
      ];
    };
  };
}
