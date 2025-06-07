{ pkgs, lib, homedir, dotfiledir, config, ... }:
let
  stylixPalette = with config.lib.stylix.colors.withHashtag; ''
    require('mini.base16').setup({
      palette = {
        base00 = '${base00}', base01 = '${base01}', base02 = '${base02}', base03 = '${base03}',
        base04 = '${base04}', base05 = '${base05}', base06 = '${base06}', base07 = '${base07}',
        base08 = '${base08}', base09 = '${base09}', base0A = '${base0A}', base0B = '${base0B}',
        base0C = '${base0C}', base0D = '${base0D}', base0E = '${base0E}', base0F = '${base0F}'
      }
    })
  '';
in {
  stylix.targets.neovim.enable = false;
  home.file.nvim-config = {
    target = homedir + "/.config/nvim/init.lua";
    source = config.lib.file.mkOutOfStoreSymlink dotfiledir + "/nvim/init.lua";
  };
  home.file.nvim-palette = {
    target = homedir + "/.config/nvim/lua/palette.lua";
    text = stylixPalette;
  };

  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins;
      [
        gitsigns-nvim
        which-key-nvim
        telescope-nvim
        nvim-lspconfig
        fidget-nvim
        cmp-nvim-lsp
        conform-nvim
        nvim-cmp
        todo-comments-nvim
        nvim-treesitter
        neo-tree-nvim
        base16-nvim
        telescope-fzf-native-nvim
        luasnip
        cmp_luasnip
        harpoon
        oil-nvim
        coq_nvim
        blink-cmp
        orgmode
        mini-base16
        (pkgs.callPackage ../../program-config/neovim/custom-plugs/org-bullets.nix {})
      ] ++ (with pkgs.vimPlugins.nvim-treesitter-parsers; [
        c
        cpp
        rust
        html
        json
        javascript
        typescript
        java
        tsx
        svelte
        css
        dockerfile
        nix
        lua
        go
        gitignore
        haskell
        python
        toml
        tmux
        tsx
        yaml
        zig
        c_sharp
        #org-nvim
      ]);
  };
}
