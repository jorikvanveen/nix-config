{ inputs, pkgs, ... }: {
  environment.systemPackages = [
    (pkgs.helium or inputs.helium-flake.packages.x86_64-linux.helium)
  ];
}
