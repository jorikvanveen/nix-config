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
          rev = "4b662587170196783ae0abd10fb34161d30db394"; # Crimson desert flicker fix
          hash = "sha256-Li83P+YzAiXeDj4CntY8bcgFfqJQMCm6cyndzR5JTK4=";
        };
      });
    })
  ];
}
