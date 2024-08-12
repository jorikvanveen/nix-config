{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs_stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs_stable";
    nur.url = "github:nix-community/NUR";
  };

  outputs = { self, nixpkgs, nixpkgs_stable, home-manager, nur, ... } @ inputs:
  let
    unstable = nixpkgs.legacyPackages.x86_64-linux;
    pkgs = nixpkgs_stable.legacyPackages.x86_64-linux;
  in
  {
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.main = import ./home.nix;
          home-manager.backupFileExtension = "hmbak";
        }
      ];
    };
  };
}
