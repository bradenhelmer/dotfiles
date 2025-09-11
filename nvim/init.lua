-- Set leader first for lazy
vim.g.mapleader = ','

vim.g.python3_host_prog = '/home/bradenhelmer/dev/__py_nvim_env__/bin/python3'

require("plugins")
require("lsp")

-- Abbreviations
vim.cmd.cnoreabbrev({ "W!", "w!" })
vim.cmd.cnoreabbrev({ "Q!", "q!" })
vim.cmd.cnoreabbrev({ "Qall!", "qall!" })
vim.cmd.cnoreabbrev({ "Wq", "wq" })
vim.cmd.cnoreabbrev({ "Wa", "wa" })
vim.cmd.cnoreabbrev({ "wQ", "wq" })
vim.cmd.cnoreabbrev({ "WQ", "wq" })
vim.cmd.cnoreabbrev({ "W", "w" })
vim.cmd.cnoreabbrev({ "Q", "q" })
vim.cmd.cnoreabbrev({ "X", "x" })
vim.cmd.cnoreabbrev({ "Qall", "qall" })

-- Setters and other misc config/globals
vim.opt.cursorline = true
vim.opt.syntax = 'on'
vim.opt.number = true
vim.opt.encoding = 'utf-8'
vim.opt.mouse = 'a'
vim.opt.background = 'dark'
vim.opt.rnu = true
vim.opt.formatoptions = { j = true, c = true, r = true, o = true, q = true, l = true }
vim.opt.clipboard = 'unnamedplus'
vim.opt.updatetime = 50
vim.opt.cindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.scrolloff = 10

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "cuda", "cpp", "h", "c" },
	callback = function()
		vim.opt_local.shiftwidth = 2
	end
})

-- Vanilla Mappings
vim.keymap.set('n', '\\\\', '<ESC> :!')
vim.keymap.set('i', 'jj', '<ESC>')
vim.keymap.set('n', '<leader><tab>', '<c-w>w')
vim.keymap.set('n', '<c-s>', ':w<cr>')
vim.keymap.set('i', '<c-s>', '<esc>:w<cr>a')
vim.keymap.set('n', '<leader>x', ':Explore<cr>')
vim.keymap.set('n', '<leader>R', ":source " .. vim.fn.stdpath('config') .. "/init.lua<CR>")
vim.keymap.set('n', '<leader>so', function() vim.opt.scrolloff = 999 - vim.o.scrolloff end)

-- LLVM / MLIR Stuff
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.inc", "*.def" },
	callback = function()
		vim.opt.filetype = "cpp"
	end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.mlir" },
	callback = function()
		vim.opt.filetype = "mlir"
	end
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.ll" },
	callback = function()
		vim.opt.filetype = "llvm"
	end
})
-- Quick Debug Statments
vim.keymap.set('n', '<leader>T', function()
	local filetype = vim.bo.filetype
	if filetype == "cpp" then
		vim.cmd("normal ostd::cout << \"TEST\";")
	elseif filetype == "python" then
		vim.cmd("normal oprint(\"Test\")")
	elseif filetype == "c" or filetype == "cuda" then
		vim.cmd("normal oprintf(\"Test\\n\");")
	end
end)

-- Change Background
vim.keymap.set('n', '<leader>bg', function()
	local bg = vim.opt.background:get()
	if bg == "dark" then
		vim.opt.background = "light"
	else
		vim.opt.background = "dark"
	end
end)
