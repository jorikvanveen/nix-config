{
  programs.ghostty = {
    enable = true;
    settings = {
      keybind = [
        "clear"
        "ctrl+t=new_tab"
        "ctrl+,=previous_tab"
        "ctrl+.=next_tab"
        "ctrl+q=close_surface"
        "ctrl+shift+c=copy_from_clipboard"
        "ctrl+shift+v=paste_from_selection"
      ];
    };
  };
}
