vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true

-- Make line numbers default
vim.opt.number = true
vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Enable break indent
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- Show which line your cursor is on
vim.opt.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10
vim.opt.termguicolors = true

-- Show a marker at column 80 to encourage reasonable line length
vim.opt.colorcolumn = "80"

vim.keymap.set("n", "<C-n>", ":Neotree<CR>")

-- OIL
require('oil').setup()

-- TELESCOPE
vim.keymap.set("n", "<leader>ff", function() require'telescope.builtin'.find_files {} end)
vim.keymap.set("n", "<leader>gf", function() require'telescope.builtin'.git_files {} end)
vim.keymap.set("n", "<leader>tlg", function() require'telescope.builtin'.live_grep {} end)
vim.keymap.set("n", "<leader>ws", "<cmd>Telescope lsp_workspace_symbols<CR>")
require'telescope'.setup {
  extensions = {
    fzf_writer = {
      minimum_grep_characters = 2,
      minimum_files_characters = 2,

      use_highlighter = true
    }
  }
}

-- LSPCONFIG
local lsps = {
  rust_analyzer = {},
  nixd = {
    settings = {
      nixd = {
        formatting = {
          command = { "nixfmt" }
        }
      }
    },
  },
  jdtls = {},
  tinymist = {},
  markdown_oxide = {},
  pyright = {},
  gopls = {},
  vtsls = {},
  tailwindcss = {
    filetypes = { "aspnetcorerazor", "astro", "astro-markdown", "blade",
      "clojure", "django-html", "htmldjango", "edge", "eelixir", "elixir", "ejs",
      "erb", "eruby", "gohtml", "gohtmltmpl", "haml", "handlebars", "hbs",
      "html", "htmlangular", "html-eex", "heex", "jade", "leaf", "liquid",
      "markdown", "mdx", "mustache", "njk", "nunjucks", "php", "razor", "slim",
      "twig", "css", "less", "postcss", "sass", "scss", "stylus", "sugarss",
      "javascript", "javascriptreact", "reason", "rescript", "typescript",
      "typescriptreact", "vue", "svelte", "templ"
    }
  },
  omnisharp = {},
  [ "jsonls" ] = {}
};

for lsp,config in pairs(lsps) do
  -- vim.lsp.config(lsp, coq.lsp_ensure_capabilities(config))
  vim.lsp.enable(lsp)
end

vim.keymap.set("n", "<leader>gd", function() vim.lsp.buf.definition() end)
vim.keymap.set("n", "<leader>gr", function() vim.lsp.buf.references() end)
vim.keymap.set("n", "E", function() vim.diagnostic.open_float() end)
vim.keymap.set("n", "<leader>ca", function() vim.lsp.buf.code_action() end)
vim.keymap.set("n", "<leader>rn", function() vim.lsp.buf.rename() end)
vim.keymap.set("n", "<leader>fm", function() vim.lsp.buf.format() end)

vim.diagnostic.config({
  float = {
    border = "rounded",
    focusable = false,
    style = "minimal",
  }
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

-- HARPOON
vim.keymap.set("n", "<leader>ah", function() require("harpoon.mark").add_file() end)
vim.keymap.set("n", "<leader><leader>", function() require("harpoon.ui").toggle_quick_menu() end)
vim.keymap.set("n", "<leader>1", function() require("harpoon.ui").nav_file(1) end)
vim.keymap.set("n", "<leader>2", function() require("harpoon.ui").nav_file(2) end)
vim.keymap.set("n", "<leader>3", function() require("harpoon.ui").nav_file(3) end)
vim.keymap.set("n", "<leader>4", function() require("harpoon.ui").nav_file(4) end)
vim.keymap.set("n", "<leader>5", function() require("harpoon.ui").nav_file(5) end)
vim.keymap.set("n", "<leader>6", function() require("harpoon.ui").nav_file(6) end)
vim.keymap.set("n", "<leader>7", function() require("harpoon.ui").nav_file(7) end)
vim.keymap.set("n", "<leader>8", function() require("harpoon.ui").nav_file(8) end)
vim.keymap.set("n", "<leader>9", function() require("harpoon.ui").nav_file(9) end)
vim.keymap.set("n", "<leader>0", function() require("harpoon.ui").nav_file(10) end)

-- MINI.BASE16 colors
if (require("mini.base16").config.palette == nil) then
  require("mini.base16").setup({
    palette = {
      base00 = "#1e1e2e", -- base
      base01 = "#181825", -- mantle
      base02 = "#313244", -- surface0
      base03 = "#45475a", -- surface1
      base04 = "#585b70", -- surface2
      base05 = "#cdd6f4", -- text
      base06 = "#f5e0dc", -- rosewater
      base07 = "#b4befe", -- lavender
      base08 = "#f38ba8", -- red
      base09 = "#fab387", -- peach
      base0A = "#f9e2af", -- yellow
      base0B = "#a6e3a1", -- green
      base0C = "#94e2d5", -- teal
      base0D = "#89b4fa", -- blue
      base0E = "#cba6f7", -- mauve
      base0F = "#f2cdcd"  -- flamingo
    }
  })
end

local palette = require("mini.base16").config.palette;

-- FIDGET
require("fidget").setup {}

require("blink.cmp").setup {
  keymap = {
    preset = "enter"
  },
  completion = { documentation = { auto_show = true } },
}

-- orgmode
require('orgmode').setup({
  org_agenda_files = '~/shared/personal/orgmode/tasks.org',
  org_default_notes_file = '~/shared/personal/orgmode/refile.org',
  org_todo_keywords = { "TODO(t)", "NOW", "|", "DONE", "CANX" },
  win_split_mode = "float",
  org_capture_templates = {
    t = { description = "Task", template = "** TODO %?" }
  },
  org_agenda_span = 'day',
  org_todo_keyword_faces = {
    TODO = ":foreground " .. palette.base00 .. " :background " .. palette.base0C .. " :weight bold",
    NOW =  ":foreground " .. palette.base00 .. " :background " .. palette.base06 .. " :weight bold",
    DONE = ":foreground " .. palette.base00 .. " :background " .. palette.base0B .. " :weight bold",
    CANX = ":foreground " .. palette.base00 .. " :background " .. palette.base04 .. " :weight bold"
  }
})

require('org-bullets').setup()


