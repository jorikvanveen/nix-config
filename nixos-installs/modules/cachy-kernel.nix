{ pkgs, inputs, ... }: {
  imports = [
    inputs.chaotic.nixosModules.default
  ];

  #boot.kernelPackages = pkgs.linuxPackages_cachyos;

  # Linux 6.14.7 contains amdgpu regression
  boot.kernelPackages = pkgs.linuxPackagesFor (pkgs.linux_6_14.override rec {
    argsOverride = {
      src = pkgs.fetchurl {
        url = "mirror://kernel/linux/kernel/v6.x/linux-${version}.tar.xz";
        sha256 = "";
      };
    };
    version = "6.14.6";
    modDirVersion = "6.14.6";
  });
}
