{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-linux6-14-6.url = "github:nixos/nixpkgs?ref=64458d571301c14aaaa8e70c925ccaae04f97ea7";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:nix-community/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    zen_flake.url = "github:0xc000022070/zen-browser-flake";
    zen_flake.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    apple-fonts.url = "github:Lyndeno/apple-fonts.nix";
    apple-fonts.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix.url = "github:Gerg-L/spicetify-nix";
    spicetify-nix.inputs.nixpkgs.follows = "nixpkgs";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    chaotic.inputs.nixpkgs.follows = "nixpkgs";

    nix-minecraft.url = "github:Infinidoge/nix-minecraft";
    nix-minecraft.inputs.nixpkgs.follows = "nixpkgs";

    musnix.url = "github:musnix/musnix";
  };

  outputs = { nixpkgs, home-manager, ... } @ inputs:
    let
      system = "x86_64-linux";
      homedir = "/home/main";
      syncdir = homedir + "/shared";
      pinned-pkgs = import inputs.nixpkgs-pinned {
        inherit system;
        config.allowUnfree = true;
      };
      pkgs = import nixpkgs {
        inherit system;
      };
      pkgs-stable = import inputs.nixpkgs-stable {
        inherit system;
      };
    in
    {
      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs homedir syncdir pinned-pkgs pkgs-stable; };
        modules = [
          ./nixos-installs/nixos-tp-p15v.nix
          home-manager.nixosModules.home-manager
          inputs.musnix.nixosModules.musnix
          {
            nixpkgs.config.permittedInsecurePackages = [
              "electron-33.4.11"
            ];
          }
          {
            home-manager.backupFileExtension = "hmbak";
            home-manager.extraSpecialArgs = { inherit homedir syncdir pkgs-stable; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.main = import ./homes/nixos-tp-p15v.nix;
          }
        ];
      };
      nixosConfigurations.nixos-pc = let unstable = pkgs; in nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs homedir syncdir unstable pinned-pkgs pkgs-stable; };
        modules = [
          ./nixos-installs/nixos-pc.nix
          inputs.musnix.nixosModules.musnix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.permittedInsecurePackages = [
              "electron-33.4.11"
            ];
          }
          {
            home-manager.backupFileExtension = "hmbak";
            home-manager.extraSpecialArgs = { inherit homedir pkgs-stable; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.main = import ./homes/nixos-pc.nix;
          }
        ];
      };
      nixosConfigurations.nixos-homelab = let
        syncdir = homedir + "/data";
        
        unstable = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit inputs homedir syncdir unstable pkgs-stable pinned-pkgs; };
        modules = [
          {
            nixpkgs.config.allowUnfree = pkgs.lib.mkForce true;

          }
          ./nixos-installs/nixos-homelab.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.backupFileExtension = "hmbak";
            home-manager.extraSpecialArgs = { inherit homedir pkgs-stable; };
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.main = import ./homes/nixos-homelab.nix;
          }
        ];
      };
      devShells.x86_64-linux.default = pkgs.mkShell {
        buildInputs = [
          pkgs.nixd
          pkgs.sops
        ];
      };
    };
}
