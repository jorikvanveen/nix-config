{ inputs, ... }:
let
  pkgs = import inputs.nixpkgs-stable {
    system = "x86_64-linux";
  };
in
{
  programs.kodi.enable = true;
  programs.kodi.package = pkgs.kodi-wayland.withPackages (k-pkgs: [
    k-pkgs.jellyfin
    k-pkgs.joystick
  ]);
}
