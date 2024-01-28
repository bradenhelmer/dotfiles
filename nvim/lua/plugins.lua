-- Plugin Management

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
	"Yggdroot/indentLine",
	"907th/vim-auto-save",
	"nvim-treesitter/nvim-treesitter",
	"matze/vim-move",
	"tpope/vim-surround",
	"Mofiqul/vscode.nvim",
	"othree/html5.vim",
	"romgrk/barbar.nvim",
	"nvim-tree/nvim-web-devicons",
	"nvim-lualine/lualine.nvim",
	"honza/vim-snippets",
	"gko/vim-coloresque",
	"junegunn/fzf",
	"junegunn/fzf.vim",
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"SirVer/ultisnips",
	"quangnguyen30192/cmp-nvim-ultisnips",
	"Raimondi/delimitMate",
	"jiangmiao/auto-pairs",
	"bradenhelmer/nvim-syncer",
	-- "mfussenegger/nvim-jdtls"
})

-- VsCode Theme
vim.opt.background = 'dark'
local c = require('vscode.colors').get_colors()
require('vscode').setup({
	italic_comments = true,
})
require('vscode').load()

-- vim-auto-save
vim.g.auto_save_events = { "InsertLeave", "TextChanged" }
vim.g.auto_save = 1

-- fzf
vim.keymap.set('n', '<Leader>e', ':Files<CR>')

-- barbar.nvim
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>')
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>')
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>')
vim.keymap.set('n', '<A-s-c>', '<Cmd>BufferRestore<CR>')

-- tree-stiter
require 'nvim-treesitter.configs'.setup {
	sync_install = false,
	ensure_installed = { "python", "cpp", "vim", "lua" },
	ignore_install = { "" },
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "yaml" } }
}

-- lualine
require('lualine').setup {
	options = { theme = 'vscode' }
}

-- nvim-cmp
local cmp = require 'cmp'
require("cmp_nvim_ultisnips").setup {}
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")


cmp.setup({
	snippet = {
		expand = function(args) vim.fn["UltiSnips#Anon"](args.body) end,
	},

	mapping = cmp.mapping.preset.insert({
		['<C-b>'] = cmp.mapping.scroll_docs(-4),
		['<C-f>'] = cmp.mapping.scroll_docs(4),
		['<TAB>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
		['<S-TAB>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
		['<C-Space>'] = cmp.mapping.complete(),
		['<C-e>'] = cmp.mapping.abort(),
		['<CR>'] = cmp.mapping.confirm(),
	}),

	sources = cmp.config.sources({
		{ name = 'nvim_lsp' },
		{ name = 'ultisnips' },
		{ name = 'vim-snippets' },
		{ name = 'buffer' }
	})
})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
	sources = cmp.config.sources({
		{ name = 'git' },
	}, {
		{ name = 'buffer' },
	})
})

cmp.setup.cmdline({ '/', '?' }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = 'buffer' }
	}
})

cmp.setup.cmdline(':', {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = 'path' }
	}, {
		{ name = 'cmdline' }
	})
})

-- nvim-syncer
local nvim_syncer = require("nvim-syncer")
vim.keymap.set('n', "<leader>sd", ":SyncDown<CR>")
vim.keymap.set('n', "<leader>su", ":SyncUp<CR>")
