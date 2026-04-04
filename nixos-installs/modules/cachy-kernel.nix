{ pkgs, inputs, ... }: {
  nixpkgs.overlays = [
    inputs.cachy-flake.overlays.pinned
  ];
  boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest-lto;
}
