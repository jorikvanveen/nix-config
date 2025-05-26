{
  programs.ghostty = {
    enable = true;
    settings = {
      command = "nu";
      keybind = [
        "clear"
        "ctrl+t=new_tab"
        "ctrl+,=previous_tab"
        "ctrl+.=next_tab"
        "ctrl+q=close_surface"
        "ctrl+shift+c=copy_to_clipboard"
        "ctrl+shift+v=paste_from_clipboard"
        "ctrl++=increase_font_size"
        "ctrl+-=decrease_font_size"
      ];
    };
  };
}
