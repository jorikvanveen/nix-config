{ inputs, ... }: {
  imports = [
    inputs.spicetify-nix.nixosModules.default
  ];
  
  programs.spicetify.enable = true;
}
