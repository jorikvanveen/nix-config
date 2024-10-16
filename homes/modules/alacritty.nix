{ lib, ... }: {
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.decorations = "None";
    window.padding = { x = 1; y = 1; };
  };
}
