{ pkgs, inputs, ... }: let
  kernel = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
in {
  nixpkgs.overlays = [
    inputs.cachy-flake.overlays.pinned
  ];
  boot.kernelPackages = kernel;
  boot.extraModulePackages = [ kernel.zenergy ];
  boot.kernelModules = [ "zenergy" "coretemp" "k10temp" ];
}
