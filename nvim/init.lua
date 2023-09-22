-- Leader, other legacies
vim.g.mapleader = ','
vim.cmd([[ so ~/.config/nvim/legacy.vim ]])

--theme
vim.o.background = 'dark'
local c = require('vscode.colors').get_colors()
require('vscode').setup({
    italic_comments = true,
})
require('vscode').load()

-- setup must be called before loading the colorscheme
-- Default options:
-- require("gruvbox").setup({
--   undercurl = true,
--   underline = true,
--   bold = false,
--   italic = {
--     strings = false,
--     emphasis = true,
--     comments = true,
--     operators = false,
--     folds = true,
--   },
--   strikethrough = true,
--   invert_selection = false,
--   invert_signs = false,
--   invert_tabline = false,
--   invert_intend_guides = false,
--   inverse = true, -- invert background for search, diffs, statuslines and errors
--   contrast = "", -- can be "hard", "soft" or empty string
--   palette_overrides = {},
--   overrides = {},
--   dim_inactive = false,
--   transparent_mode = false,
-- })
-- vim.cmd("colorscheme gruvbox")

-- tree-stiter
require'nvim-treesitter.configs'.setup {
  sync_install = false,
  ensure_installed = { "python", "cpp", "vim", "lua" }, 
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = false,
  },
 indent = {enable = true, disable = { "yaml" }} 
}
require('nvim-treesitter.parsers').get_parser_configs().asm = {
    install_info = {
        url = 'https://github.com/rush-rs/tree-sitter-asm.git',
        files = { 'src/parser.c' },
        branch = 'main',
    },
}

-- Reload change
vim.api.nvim_set_keymap('n', '<leader>so', ':lua vim.cmd([[ so ~/.config/nvim/legacy.vim ]])', { noremap = true, silent = true })

