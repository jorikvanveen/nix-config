{ pkgs, lib, inputs, ... }:
let
  xwayland-satellite = (pkgs.xwayland-satellite.overrideAttrs
    (finalAttrs: prevAttrs: {
      src = pkgs.fetchFromGitHub {
        owner = "Supreeeme";
        repo = "xwayland-satellite";
        rev = "ec9ff64c1e0cbec42710b580b7c0f759b1694e72";
        hash = "sha256-GAqhWoxaBIk0tgoecZPa8gTHDHxNc0JtlwWHZN2iOOo=";
      };
      version = "0.5.1";
      cargoHash = "sha256-QsU960aRU+ErU7vwoNyuOf2YmKjEWW3yCnQoikLaYeA=";
      cargoDeps = pkgs.rustPlatform.fetchCargoVendor {
        inherit (finalAttrs) pname src version;
        hash = finalAttrs.cargoHash;
      };
    }));
  ags-bar = inputs.ags-shell.packages.x86_64-linux.default;
in {
  programs.niri.enable = true;
  programs.waybar.enable = true;
  services.xserver.displayManager.gdm.enable = lib.mkDefault true;
  services.blueman.enable = true;
  systemd.user.services.ags-bar = {
    wantedBy = [ "defaul.target" ];
    script = "${ags-bar}/bin/my-shell";
  };
  environment.systemPackages =
    [ pkgs.fuzzel pkgs.swaylock xwayland-satellite pkgs.pavucontrol ];
}
