{ pkgs, ... }: let
in {
  environment.systemPackages = [
    pkgs.lutris
  ];
}
