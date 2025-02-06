{ pkgs-stable, pkgs, ... }: let
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    extraLuaConfig = builtins.readFile ../../program-config/neovim/init.lua;
    plugins = with pkgs.vimPlugins; [
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
    ] ++ [
      pkgs-stable.vimPlugins.coq_nvim # Broken in unstable as of 6 feb 2025
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
    ]);
  };
}
