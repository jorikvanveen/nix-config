{ pkgs, inputs, ... }: {
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  #boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # Linux 6.14.7 contains amdgpu regression
  boot.kernelPackages = inputs.nixpkgs-linux6-14-6.legacyPackages.x86_64-linux.linuxPackages;
}
