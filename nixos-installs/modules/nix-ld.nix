{ pkgs, ... }: {
  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    pkgs.xorg.libXtst
    pkgs.xorg.libXi
  ];
}
