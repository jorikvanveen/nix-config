{ pkgs, chaotic, ... }: {
  imports = [
    chaotic.nixosModules.default
  ];

  boot.kernelPackages = pkgs.linuxPackages_cachyos;
}
