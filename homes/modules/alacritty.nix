{ lib, ... }: {
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    window.decorations = "None";
    window.padding = { x = 5; y = 5; };
    env.TERM = "alacritty-direct";
  };
}
