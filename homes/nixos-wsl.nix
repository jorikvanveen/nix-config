{ inputs, ... }: {
  imports = [
    ./generic.nix
    ./modules/main-user.nix
    inputs.nixos-wsl.nixosModules.default
    {
      system.stateVersion = "25.11";
      wsl.enable = true;
    }
  ];
}
