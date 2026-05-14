{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.mesa
  ];

  nixpkgs.overlays = [
    (final: prev: {
      mesa = (
        (prev.mesa.overrideAttrs (oldAttrs: {
          version = "26.1-git";
          src = pkgs.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "mesa";
            repo = "mesa";
            rev = "1323939f6314fdeecf5be5ba3f5680380cd5783e";
            hash = "sha256-RlnnkpvIu1f1+pKV94L4WntCS/LCxFBO11kktR8+RY8=";
          };
        })).override
          {
            libdrm = (
              prev.libdrm.overrideAttrs (oldAttrs: rec {
                version = "2.4.133";
                src = pkgs.fetchurl {
                  url = "https://dri.freedesktop.org/libdrm/libdrm-${version}.tar.xz";
                  hash = "sha256-/Gj50LoupjyUMqKZ4U/qCfrXqKZugDn814AspZ93tPU=";
                };
              })
            );
          }
      );
    })
  ];
}
