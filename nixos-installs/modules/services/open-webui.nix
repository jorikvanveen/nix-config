{ pkgs, inputs, system, ... }: let
  pkgs-stable = import inputs.nixpkgs-stable {
    inherit system;
    config.allowUnfree = true;
  };
in {
  services.open-webui = {
    enable = true;
    port = 8090;
    package = pkgs-stable.open-webui; # This build is a piece of shit
  };
}
