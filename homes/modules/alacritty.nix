{ lib, ... }: {
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.decorations = "None";
    window.opacity = lib.mkForce 0.7;
    window.blur = true;
  };
}
