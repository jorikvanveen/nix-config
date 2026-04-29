{ pkgs, ... }: {
#nixpkgs.overlays = [
  #   (final: prev: {
  #     gamescope = prev.gamescope-wsi;
  #   })
  # ];
  programs.gamescope = {
    enable = true;
  };
}
