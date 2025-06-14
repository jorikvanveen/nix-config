{ vimPlugins, callPackage }:
let org-bullets = (callPackage ./custom-plugs/org-bullets.nix { });
in with vimPlugins;
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
  mini-base16
  telescope-fzf-native-nvim
  luasnip
  cmp_luasnip
  harpoon
  oil-nvim
  coq_nvim
  blink-cmp
  orgmode
  org-bullets
] ++ (with vimPlugins.nvim-treesitter-parsers; [
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
])

