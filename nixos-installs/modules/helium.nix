{ inputs, ... }: {
  environment.systemPackages = [
    inputs.helium-flake.packages.x86_64-linux.helium 
  ];
}
