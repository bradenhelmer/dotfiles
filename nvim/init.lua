-- Set leader first for lazy
vim.g.mapleader = ','

-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	"tpope/vim-commentary",
	"airblade/vim-gitgutter",
	"Raimondi/delimitMate",
	"majutsushi/tagbar",
	"Yggdroot/indentLine",
	"907th/vim-auto-save",
	"dart-lang/dart-vim-plugin",
	"nvim-treesitter/nvim-treesitter",
	"nvim-treesitter/playground",
	"Shirk/vim-gas",
	"APZelos/blamer.nvim",
	"matze/vim-move",
	"tpope/vim-surround" ,
	"Mofiqul/vscode.nvim",
	"othree/html5.vim",
	"lewis6991/gitsigns.nvim", 
	"romgrk/barbar.nvim", 
	"nvim-tree/nvim-web-devicons",
	"nvim-lualine/lualine.nvim",
	"chrisbra/unicode.vim",
    "honza/vim-snippets",
    "gko/vim-coloresque",
    "junegunn/fzf",
    "junegunn/fzf.vim",
})


-- Leader, other legacies
vim.cmd([[ so ~/.config/nvim/legacy.vim ]])

--theme
vim.o.background = 'dark'
local c = require('vscode.colors').get_colors()
require('vscode').setup({
    italic_comments = true,
})
require('vscode').load()

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

require('lualine').setup {
    options = { theme = 'vscode' }
}

-- Abbreviations
vim.cmd.cnoreabbrev({"W!", "w!"})
vim.cmd.cnoreabbrev({"Q!", "q!"})
vim.cmd.cnoreabbrev({"Qall!", "qall!"})
vim.cmd.cnoreabbrev({"Wq", "wq"})
vim.cmd.cnoreabbrev({"Wa", "wa"})
vim.cmd.cnoreabbrev({"wQ", "wq"})
vim.cmd.cnoreabbrev({"WQ", "wq"})
vim.cmd.cnoreabbrev({"W", "w"})
vim.cmd.cnoreabbrev({"Q", "w"})
vim.cmd.cnoreabbrev({"X", "w"})
vim.cmd.cnoreabbrev({"Qall", "qall"})

-- Setters and other misc config/globals
vim.opt.cursorline = true
vim.opt.syntax = 'on'
vim.opt.grepprg = 'ag --nogroup --nocolor'
vim.opt.number = true
vim.opt.encoding = 'utf-8'
vim.opt.mouse = 'a'
vim.opt.background = 'dark'
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.rnu = true
vim.opt.formatoptions = {j = true, c = true, r = true, o = true, q = true, l = true}
vim.opt.autoindent = true
vim.opt.clipboard = 'unnamedplus'
vim.g.python_host_prog = '/usr/bin/python3'

-- Vanilla Mappings
vim.keymap.set('i', '\\\\', '<ESC> :!')
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', '<leader><tab>', '<c-w>w')
vim.keymap.set('n', '<c-s>', ':w<cr>')
vim.keymap.set('i', '<c-s>', '<esc>:w<cr>a')
vim.keymap.set('n', '<leader>x' ,':explore<cr>')

-- vim-auto-save
vim.g.auto_save_events = {"InsertLeave", "TextChanged"}
vim.g.auto_save = 1

-- fzf
vim.cmd("let $FZF_DEFAULTS_COMMAND = 'ag --hidden --ignore node_modules -U -g \"\"'")
vim.keymap.set('n', '<Leader>e', ':Files<CR>')

-- barbar.nvim
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>')
vim.keymap.set('n', '<A-s-c>', '<Cmd>BufferRestore<CR>')

vim.api.nvim_create_autocmd({"BufRead","BufNewFile"},
    {
    pattern = {"*.cpp.inc", "*.h.inc"}, 
    command= "set filetype=cpp"
    }
)

