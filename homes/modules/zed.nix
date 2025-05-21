{ pkgs, ... }: {
  programs.zed-editor = {
    enable = true;
    extensions = [
      "html"
      "toml"
      "git-firefly"
      "sql"
      "java"
      "vue"
      "java"
      "java-eclipse-jdtls"
      "make"
      "svelte"
      "nix"
      "pylsp"
      "assembly"
      "nu"
    ];

    userSettings = {
      vim_mode = true;
      ui_font_size = 14;
      buffer_font_size = 14;
      # Enable ligatures
      buffer_font_features.calt = true;
      relative_line_numbers = true;
      # Remove when stylix supports zed
      ui_font_family = "SFMono Nerd Font";
      buffer_font_family = "SFMono Nerd Font";
      tab_bar.show = false;
      base_keymap = "VSCode";
      cursor_blink = false;
      auto_update = false;
      use_autoclose = true;
      load_direnv = "shell_hook";
      terminal.shell.program = "${pkgs.nushell}/bin/nu";
    };

    userKeymaps = [
      {
        context = "FileFinder";
        bindings = {
          tab = "menu::SelectNext";
          shift-tab = "menu::SelectPrev";
          ctrl-m = ["workspace::SendKeystrokes" "up"];
        };
      }
      {
        context = "Editor && vim_mode != insert && !BufferSearchBar";
        bindings = {
            "space space" = "tab_switcher::Toggle";
            "space f f" = "file_finder::Toggle";
            "space w s" = "project_symbols::Toggle";
            "space g r" = "editor::FindAllReferences";
            "space c a" = "editor::ToggleCodeActions";
            "space r n" = "editor::Rename";
        };
      }
      {
        context = "Terminal";
        bindings = {
          escape = ["terminal::SendKeystroke" "escape"];
          ctrl-b = ["terminal::SendKeystroke" "ctrl-b"];
          "ctrl-\\" = ["workspace::ActivatePaneInDirection" "Up"];
        };
      }
      {
        context = "Editor";
        bindings = {
          ctrl-j = "terminal_panel::ToggleFocus";
        };
      }
      {
        context = "Editor && (showing_code_actions || showing_completions)";
        bindings = {
          tab = ["workspace::SendKeystrokes" "down"];
          shift-tab = ["workspace::SendKeystrokes" "up"];
        };
      }
      {
        context = "Workspace";
        bindings = {
          #ctrl-n = "worspace::ToggleLeftDock";
          alt-w = "diagnostics::ToggleWarnings";
        };
      }
      {
        context = "TabSwitcher";
        bindings = {
          j = "menu::SelectNext";
          k = "menu::SelectPrev";
          x = "tab_switcher::CloseSelectedItem";
        };
      }
    ];
  };
}
