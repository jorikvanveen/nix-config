{
  imports = [
    ./stylix-custom-nu.nix
  ];
  stylix.targets.nushell.enable = false;
  stylix.targets.vesktop.enable = true;
  stylix.targets.forge.enable = true;
  stylix.targets.ghostty.enable = true;
}
