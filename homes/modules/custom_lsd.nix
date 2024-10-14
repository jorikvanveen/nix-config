{ pkgs, ... }:
let
  mylsd = pkgs.lsd.override (previous: {
    rustPlatform = previous.rustPlatform // {
      buildRustPackage = args: previous.rustPlatform.buildRustPackage (args // {
        src = previous.fetchFromGitHub {
          owner = "jorikvanveen";
          repo = "lsd";
          rev = "c9b76cc5eec5247ebc7442c5d7148c62ac0e9fb5";
          hash = "sha256-nIu4iytDLPpTgz4Fqnwcw2DPELSzPVJXC9vuoZY46AE=";
        };
        cargoHash = "sha256-chryC4YDvd8c7fIiHMWi+g5JYZJqkLPknSCgzYVKucE=";
      });
    };
  });
in {
  home.packages = [
    mylsd
  ];
}
