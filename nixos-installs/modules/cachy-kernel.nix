{ pkgs, inputs, ... }: let
  kernel = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto-x86_64-v3;
in {
  nixpkgs.overlays = [
    inputs.cachy-flake.overlays.pinned
  ];
  boot.kernelPackages = kernel;
  boot.extraModulePackages = [ kernel.zenergy ];
  boot.kernelModules = [ "zenergy" "coretemp" "k10temp" ];
}
