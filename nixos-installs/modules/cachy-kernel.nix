{ _pkgs, inputs, ... }:
let
  pkgs = import inputs.chaotic {
    system = "x86_64-linux";
  };
in
{
  boot.kernelPackages = inputs.chaotic.packages.x86_64-linux.linux_cachyos;
}
