{ _pkgs, inputs, ... }:
let
  pkgs = import inputs.cachy-flake {
    system = "x86_64-linux";
  };
in
{
  boot.kernelPackages = pkgs.x86_64-linux.linux_cachyos;
}
