{ pkgs, ... }:
let
  mylsd = pkgs.lsd.override (previous: {
    rustPlatform = previous.rustPlatform // {
      buildRustPackage = args: previous.rustPlatform.buildRustPackage (args // {
        src = previous.fetchFromGitHub {
          owner = "jorikvanveen";
          repo = "lsd";
          rev = "fbad80e0a5f5f162495f8646eac56bc0b91361c2";
          hash = "sha256-6S7aVEoOVQ4S+0d0eqkPYrinzSlsrJeF78SL4pocy+E=";
        };
        cargoHash = "sha256-YbTfaCk1ZLP+39iI9w6KNvFXOCwIt6Op4OuhurmW1w0=";
      });
    };
  });
in {
  home.packages = [
    mylsd
  ];
}
