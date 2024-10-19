{ pkgs, ... }: let
in {
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    #extraLuaConfig = ../../program-config/neovim/init.lua;
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
    ];
  };
}
