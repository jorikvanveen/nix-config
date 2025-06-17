{
  description = "A very basic flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-24.11";
    nixpkgs-linux6-14-6.url =
      "github:nixos/nixpkgs?ref=64458d571301c14aaaa8e70c925ccaae04f97ea7";

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
    musnix.inputs.nixpkgs.follows = "nixpkgs";

    ags-shell.url = "path:./ags";
    ags-shell.inputs.nixpkgs.follows = "nixpkgs";

    zed.url = "github:zed-industries/zed?ref=v0.190.6";
    zed.inputs.nixpkgs.follows = "nixpkgs";

    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    nixos-wsl.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      makeHomeManagerModule = { home, specialArgs }: {
        home-manager.backupFileExtension = "hmbak";
        home-manager.extraSpecialArgs = specialArgs;
        home-manager.useGlobalPkgs = true;
        home-manager.useUserPackages = true;
        home-manager.users.main = home;
      };
      makeOsConfig = { home, extraModules ? [ ], extraSpecialArgs ? { }
        , homedir ? "/home/main", syncdir ? homedir + "/shared"
        , dotfiledir ? homedir + "/nix-config/dotfiles" }:
        nixpkgs.lib.nixosSystem rec {
          inherit system;
          specialArgs = {
            inherit system inputs homedir syncdir dotfiledir;
          } // extraSpecialArgs;
          modules = [
            home-manager.nixosModules.home-manager
            (makeHomeManagerModule { inherit home specialArgs; })
          ] ++ extraModules;
        };
    in {
      packages.${system}.neovim =
        import ./program-config/neovim/neovim.nix { inherit pkgs; };

      nixosConfigurations.nixos-laptop = makeOsConfig {
        home = import ./homes/nixos-tp-p15v.nix;
        extraModules = [
          ./nixos-installs/nixos-tp-p15v.nix
          inputs.musnix.nixosModules.musnix
        ];
      };
      nixosConfigurations.nixos-pc = makeOsConfig {
        home = import ./homes/nixos-pc.nix;
        extraModules =
          [ ./nixos-installs/nixos-pc.nix inputs.musnix.nixosModules.musnix ];
      };
      nixosConfigurations.nixos-homelab = makeOsConfig rec {
        home = import ./homes/nixos-homelab.nix;
        extraModules = [ ./nixos-installs/nixos-homelab.nix ];
        homedir = "/home/main";
        syncdir = homedir + "/data";
      };
      nixosConfigurations.nixos-wsl = makeOsConfig {
        home = import ./homes/nixos-wsl.nix;
        extraModules = [ ./nixos-installs/nixos-wsl.nix ];
      };

      devShells.x86_64-linux.default =
        pkgs.mkShell { buildInputs = [ pkgs.nixd pkgs.sops ]; };
    };
}
