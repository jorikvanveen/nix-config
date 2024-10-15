{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs_stable.url = "github:nixos/nixpkgs?ref=4f807e8940284ad7925ebd0a0993d2a1791acb2f";

    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    zen_flake.url = "github:0xc000022070/zen-browser-flake";
    zen_flake.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    apple-fonts.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nixpkgs_stable, home-manager, stylix, apple-fonts, ... } @ inputs:
    let
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
      stable = nixpkgs_stable.legacyPackages.x86_64-linux;
      zen_flake = inputs.zen_flake.packages.x86_64-linux;
    in
    {
      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit stable zen_flake stylix apple-fonts; };
        system = "x86_64-linux";
        modules = [
          ./nixos-installs/nixos-tp-p15v.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "hmbak";
            #home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.main = import ./homes/nixos-tp-p15v.nix;
          }
        ];
      };
    };
}
