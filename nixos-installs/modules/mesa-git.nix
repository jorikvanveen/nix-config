{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.mesa
  ];

  nixpkgs.overlays = [
    (final: prev: {
      mesa = (
        prev.mesa.overrideAttrs (oldAttrs: {
          version = "26.0-git";
          src = pkgs.fetchFromGitLab {
            domain = "gitlab.freedesktop.org";
            owner = "mesa";
            repo = "mesa";
            rev = "164633de71aa45f18ecc4133d9ae392cdb93ef21";
            hash = "sha256-3TWzjuhNuqJ606tlvOZw/m6m4w4f4MA1ylBZ7Q0553o=";
          };
        })
      );
    })
  ];
}
