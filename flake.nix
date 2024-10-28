{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-pinned.url = "github:nixos/nixpkgs?ref=a28796b8c053def7c3f839d43ca2df76d4d86bb1";
    zenpkgs.url = "github:matthewpi/nixpkgs/zen-browser";

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

    posting-flake.url = "github:jorikvanveen/posting-flake";
    posting-flake.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
    let
      homedir = "/home/main";
      pinned-pkgs = inputs.nixpkgs-pinned.legacyPackages.x86_64-linux;
      pkgs = nixpkgs.legacyPackages.x86_64-linux;
    in
    {
      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit (inputs) posting-flake zenpkgs zen_flake stylix apple-fonts spicetify-nix; inherit homedir pinned-pkgs; };
        system = "x86_64-linux";
        modules = [
          ./nixos-installs/nixos-tp-p15v.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "hmbak";
            home-manager.extraSpecialArgs = { inherit homedir; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.main = import ./homes/nixos-tp-p15v.nix;
          }
        ];
      };
      nixosConfigurations.nixos-pc = nixpkgs.lib.nixosSystem {
        specialArgs = { inherit (inputs) posting-flake zenpkgs zen_flake stylix apple-fonts spicetify-nix; inherit homedir pinned-pkgs; };
        system = "x86_64-linux";
        modules = [
          ./nixos-installs/nixos-pc.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "hmbak";
            home-manager.extraSpecialArgs = { inherit homedir; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.main = import ./homes/nixos-pc.nix;
          }
        ];
      };
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
          pkgs.nixd
        ];
      };
    };
}
