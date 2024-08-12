{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs_stable.url = "github:nixos/nixpkgs?ref=nixos-24.05";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs_stable";
    };
    ff-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs_stable";
    };
  };

  outputs = { self, nixpkgs, nixpkgs_stable, home-manager, ff-addons } @ inputs:
  let
    unstable = nixpkgs.legacyPackages.x86_64-linux;
    pkgs = nixpkgs_stable.legacyPackages.x86_64-linux;
  in
  {
    nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs unstable; };
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager.backupFileExtension = "hmbak";
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.main = import ./home.nix;
        }
      ];
    };
  };
}
