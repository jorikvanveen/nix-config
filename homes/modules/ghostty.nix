{
  programs.ghostty = {
    enable = true;
    settings = {
      keybind = [
        "clear"
        "ctrl+t=new_tab"
        "ctrl+,=previous_tab"
        "ctrl+.=next_tab"
        "ctrl+w=close_surface"
      ];
    };
  };
}
