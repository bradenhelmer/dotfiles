-- Set leader first for lazy
vim.g.mapleader = ","
vim.g.python3_host_prog = "/home/bradenhelmer/dev/__py_nvim_env__/bin/python3"

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
vim.opt.syntax = "on"
vim.opt.number = true
vim.opt.encoding = "utf-8"
vim.opt.mouse = "a"
vim.opt.background = "dark"
vim.opt.rnu = true
-- Format options:
-- j: Delete comment leader when joining lines
-- c: Auto-wrap comments using textwidth
-- q: Allow formatting comments with 'gq'
-- l: Long lines are not broken in insert mode
-- r: Auto-insert comment leader after Enter (kept for block comments)
-- o: Auto-insert comment leader after o/O (kept for block comments)
vim.opt.formatoptions = { j = true, c = true, q = true, l = true, r = true, o = true }

-- Disable auto-comment continuation for line-comment-only filetypes
-- Keep it enabled for languages with block comments (C, C++, Java, JS, CSS, etc.)
local line_comment_filetypes = {
	"python",
	"sh",
	"bash",
	"zsh",
	"fish",
	"ruby",
	"perl",
	"lua",
	"vim",
	"conf",
	"dosini",
	"gitconfig",
	"yaml",
	"toml",
}

vim.api.nvim_create_autocmd("FileType", {
	pattern = line_comment_filetypes,
	callback = function()
		vim.opt_local.formatoptions:remove({ "r", "o" })
	end,
})
vim.opt.clipboard = "unnamedplus"
vim.opt.updatetime = 50
vim.opt.cindent = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.scrolloff = 10

-- Vanilla Mappings
vim.keymap.set("n", "\\\\", "<ESC> :!")
vim.keymap.set("i", "jj", "<ESC>")
vim.keymap.set("n", "<leader><tab>", "<c-w>w")
vim.keymap.set("n", "<c-s>", ":w<cr>")
vim.keymap.set("i", "<c-s>", "<esc>:w<cr>a")
vim.keymap.set("n", "<leader>x", ":Explore<cr>")
vim.keymap.set("n", "<leader>R", ":source " .. vim.fn.stdpath("config") .. "/init.lua<CR>")
vim.keymap.set("n", "<leader>so", function()
	vim.opt.scrolloff = 999 - vim.o.scrolloff
end)

-- Scroll past end of buffer (EOF) mappings
-- These allow scrolling the viewport beyond the last line for better centering
-- Using winrestview to manipulate viewport directly, allowing scrolling past EOF
vim.keymap.set("n", "<C-d>", function()
	local view = vim.fn.winsaveview()
	local last_line = vim.fn.line("$")
	local winheight = vim.fn.winheight(0)
	local scroll_amount = math.floor(winheight / 2)

	-- Calculate max topline that allows scrolling past EOF
	local max_topline = last_line

	-- Scroll viewport down by half page
	view.topline = math.min(view.topline + scroll_amount, max_topline)

	-- Move cursor down, but don't go past last line
	local target_cursor = view.lnum + scroll_amount
	view.lnum = math.min(target_cursor, last_line)

	-- If cursor would be above the visible area, move it down
	if view.lnum < view.topline then
		view.lnum = view.topline
	end

	vim.fn.winrestview(view)
end, { noremap = true, silent = true, desc = "Scroll down half page (past EOF)" })

vim.keymap.set("n", "<C-u>", function()
	local view = vim.fn.winsaveview()
	local winheight = vim.fn.winheight(0)
	local scroll_amount = math.floor(winheight / 2)

	-- Scroll viewport up by half page
	view.topline = math.max(view.topline - scroll_amount, 1)

	-- Move cursor up
	local target_cursor = view.lnum - scroll_amount
	view.lnum = math.max(target_cursor, 1)

	-- If cursor would be below the visible area, move it up
	if view.lnum > view.topline + winheight - 1 then
		view.lnum = view.topline + winheight - 1
	end

	vim.fn.winrestview(view)
end, { noremap = true, silent = true, desc = "Scroll up half page" })

-- Enhanced Ctrl+e and Ctrl+y for smoother line-by-line scrolling past EOF
-- These use winrestview to manipulate the viewport directly
vim.keymap.set("n", "<C-e>", function()
	local view = vim.fn.winsaveview()
	local last_line = vim.fn.line("$")
	local winheight = vim.fn.winheight(0)

	-- Calculate max topline that shows empty space at bottom
	local max_topline = last_line

	if view.topline < max_topline then
		view.topline = view.topline + 1
		-- Move cursor down if it would go off-screen
		if view.lnum < view.topline then
			view.lnum = view.topline
		end
		vim.fn.winrestview(view)
	end
end, { noremap = true, silent = true, desc = "Scroll down one line (past EOF)" })

vim.keymap.set("n", "<C-y>", function()
	local view = vim.fn.winsaveview()

	if view.topline > 1 then
		view.topline = view.topline - 1
		local winheight = vim.fn.winheight(0)
		-- Move cursor up if it would go off-screen
		if view.lnum > view.topline + winheight - 1 then
			view.lnum = view.topline + winheight - 1
		end
		vim.fn.winrestview(view)
	end
end, { noremap = true, silent = true, desc = "Scroll up one line" })

-- LLVM / MLIR Stuff
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.inc", "*.def" },
	callback = function()
		vim.opt.filetype = "cpp"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.mlir" },
	callback = function()
		vim.opt.filetype = "mlir"
	end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.ll" },
	callback = function()
		vim.opt.filetype = "llvm"
	end,
})
-- Quick Debug Statments
vim.keymap.set("n", "<leader>T", function()
	local filetype = vim.bo.filetype
	if filetype == "cpp" then
		vim.cmd('normal ostd::cout << "TEST";')
	elseif filetype == "python" then
		vim.cmd('normal oprint("Test")')
	elseif filetype == "c" or filetype == "cuda" then
		vim.cmd('normal oprintf("Test\\n");')
	end
end)

-- Change Background
vim.keymap.set("n", "<leader>bg", function()
	local bg = vim.opt.background:get()
	if bg == "dark" then
		vim.opt.background = "light"
	else
		vim.opt.background = "dark"
	end
end)
