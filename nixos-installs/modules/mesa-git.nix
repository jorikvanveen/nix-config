{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.mesa
  ];

  nixpkgs.overlays = [
    (final: prev: {
      mesa = prev.mesa.overrideAttrs (oldAttrs: {
        version = "26.1-git";
        src = pkgs.fetchFromGitLab {
          domain = "gitlab.freedesktop.org";
          owner = "mesa";
          repo = "mesa";
          rev = "f09ca6234849d79cd74c5fa5c5b0726c9c1c1dbd";
          hash = "sha256-2s7efATtAzD15CQvOEqm2MtC1lgczx4Pqf61QK4LDn4=";
        };
      });
    })
  ];
}
