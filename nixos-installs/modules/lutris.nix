{ inputs, ... }: let
  pkgs = import inputs.updated-lutris-pkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in {
  environment.systemPackages = [
    pkgs.lutris
  ];
}
