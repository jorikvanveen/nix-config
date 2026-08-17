{ inputs, ... }: let
  pkgs = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
  };
in{
  home.packages = [
    pkgs.moonlight-qt
  ];
}
