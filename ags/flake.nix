
{
  description = "My Awesome Desktop Shell";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

    ags = {
      url = "github:aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ags, }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      deps = with ags.packages.${system}; [
        battery
        network
        wireplumber
        tray
        battery
        mpris
        powerprofiles
        bluetooth
        pkgs.jack_capture
        pkgs.ffmpeg
      ];
    in {
      packages.${system} = {
        default = ags.lib.bundle {
          inherit pkgs;
          src = ./.;
          name = "my-shell";
          entry = "app.ts";

          # additional libraries and executables to add to gjs' runtime
          extraPackages = deps;
        };
      };

      devShells.${system} = {
        default = pkgs.mkShell {
          buildInputs = [
            # includes astal3 astal4 astal-io by default
            (ags.packages.${system}.default.override {
              extraPackages = deps;
            })
          ];
        };
      };
    };
}

