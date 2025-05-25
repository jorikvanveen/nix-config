{
  description = "My Awesome Desktop Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ags,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    shell_deps = [
      pkgs.astal.wireplumber
      pkgs.astal.mpris
      pkgs.jack_capture
    ];
  in {
    packages.${system} = {
      default = ags.lib.bundle {
        inherit pkgs;
        src = ./.;
        name = "my-shell";
        entry = "app.ts";

        # additional libraries and executables to add to gjs' runtime
        extraPackages = shell_deps;
      };
    };

    devShells.${system} = {
      default = pkgs.mkShell {
        buildInputs = [
          pkgs.vtsls
          pkgs.nodejs
          # includes astal3 astal4 astal-io by default
          (ags.packages.${system}.default.override {
            extraPackages = shell_deps;
          })
        ];
      };
    };
  };
}
