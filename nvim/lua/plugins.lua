-- Plugin Management
-- lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
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
	"airblade/vim-gitgutter",
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
	"neovim/nvim-lspconfig",
	"hrsh7th/nvim-cmp",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	"hrsh7th/cmp-cmdline",
	"SirVer/ultisnips",
	"quangnguyen30192/cmp-nvim-ultisnips",
	"Raimondi/delimitMate",
	"windwp/nvim-autopairs",
	"bradenhelmer/nvim-syncer",
	"sindrets/diffview.nvim",
	"chrisbra/unicode.vim",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",
		dependencies = { "nvim-lua/plenary.nvim" },
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
	{
		"stevearc/conform.nvim",
		opts = {},
	},
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		---@module "ibl"
		---@type ibl.config
		opts = {},
	},
})

local opts = { silent = true }

vim.keymap.set("n", "<leader>lz", ":Lazy<CR>")

-- VsCode Theme
vim.opt.background = "dark"
local c = require("vscode.colors").get_colors()
require("vscode").setup({ italic_comments = true })
vim.cmd.colorscheme("vscode")

-- vim-auto-save
vim.g.auto_save_events = { "InsertLeave", "TextChanged" }
vim.g.auto_save = 1

-- telescope.nvim
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
require("telescope").load_extension("fzf")

-- barbar.nvim
vim.keymap.set("n", "<C-,>", "<Cmd>BufferPrevious<CR>")
vim.keymap.set("n", "<C-.>", "<Cmd>BufferNext<CR>")
vim.keymap.set("n", "<C-c>", "<Cmd>BufferClose<CR>")
vim.keymap.set("n", "<C-s-c>", "<Cmd>BufferRestore<CR>")

-- tree-stiter
require("nvim-treesitter.configs").setup({
	sync_install = false,
	ensure_installed = { "python", "cpp", "vim", "lua" },
	ignore_install = { "" },
	highlight = {
		enable = true,
		disable = { "" },
		additional_vim_regex_highlighting = false,
	},
	indent = { enable = true, disable = { "yaml" } },
})

-- lualine
require("lualine").setup({ options = { theme = "vscode" } })

-- nvim-cmp
local cmp = require("cmp")
require("cmp_nvim_ultisnips").setup({})
local cmp_ultisnips_mappings = require("cmp_nvim_ultisnips.mappings")

cmp.setup({
	snippet = {
		expand = function(args)
			vim.fn["UltiSnips#Anon"](args.body)
		end,
	},

	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<TAB>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
		["<S-TAB>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm(),
	}),

	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "ultisnips" },
		{ name = "vim-snippets" },
		{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({ { name = "git" } }, { { name = "buffer" } }),
})

cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = { { name = "buffer" } },
})

cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
})

-- nvim-syncer
local nvim_syncer = require("nvim-syncer")
vim.keymap.set("n", "<leader>sd", ":SyncDown<CR>")
vim.keymap.set("n", "<leader>su", ":SyncUp<CR>")

-- Autopairs
require("nvim-autopairs").setup()

-- indent-blankline
require("ibl").setup()

-- conform.nvim
local conform = require("conform")
conform.setup({
	formatters_by_ft = {
		lua = { "stylua" },
		python = { "black", append_args = { "--line-length", "100" } },
		c = { "clang-format" },
		cpp = { "clang-format" },
		cuda = { "clang-format" },
	},
	formatters = {
		["clang-format"] = {
			prepend_args = { "--style={IndentWidth: 4, ColumnLimit: 100}" },
		},
	},
})
vim.keymap.set("n", "<leader>fr", conform.format, opts)
