-- Set leader first for lazy
vim.g.mapleader = ','

require("plugins")
require("lsp")

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
vim.opt.smartindent = true
vim.opt.clipboard = 'unnamedplus'
vim.g.python_host_prog = '/usr/bin/python3'

-- Vanilla Mappings
vim.keymap.set('n', '\\\\', '<ESC> :!')
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', '<leader><tab>', '<c-w>w')
vim.keymap.set('n', '<c-s>', ':w<cr>')
vim.keymap.set('i', '<c-s>', '<esc>:w<cr>a')
vim.keymap.set('n', '<leader>x' ,':Explore<cr>')

-- MLIR Stuff
vim.api.nvim_create_autocmd({"BufRead","BufNewFile"},
    {
    pattern = {"*.cpp.inc", "*.h.inc"}, 
    command= "set filetype=cpp"
    }
)
