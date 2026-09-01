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
	{
		"nvim-treesitter/nvim-treesitter",
		lazy = false,
		build = ":TSUpdate",
		branch = "main",
	},
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
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"ggml-org/llama.vim",
		init = function()
			vim.g.llama_config = {
				show_info = false,
				keymap_fim_accept_full = "<S-Tab>",
				keymap_fim_accept_line = "<C-l>",
				endpoint_fim = "http://127.0.0.1:8080/infill",
			}
		end,
	},
})

local opts = { silent = true }

vim.keymap.set("n", "<leader>lz", ":Lazy<CR>")

-- VsCode Theme
vim.opt.background = "dark"
local c = require("vscode.colors").get_colors()
require("vscode").setup({ italic_comments = true })
vim.cmd.colorscheme("vscode")

-- llama.vim highlight overrides (ghost text needs to be visually distinct)
vim.api.nvim_set_hl(0, "llama_hl_fim_hint", { fg = "#6c6c6c" })
vim.api.nvim_set_hl(0, "llama_hl_fim_info", { fg = "#77ff2f" })

-- vim-auto-save
vim.g.auto_save_events = { "InsertLeave", "TextChanged" }
vim.g.auto_save = 1

-- telescope.nvim
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", function()
	builtin.find_files({ hidden = true, no_ignore = false, file_ignore_patterns = { "^.git/" } })
end, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
require("telescope").load_extension("fzf")

-- barbar.nvim
vim.keymap.set("n", "<A-,>", "<Cmd>BufferPrevious<CR>")
vim.keymap.set("n", "<A-.>", "<Cmd>BufferNext<CR>")
vim.keymap.set("n", "<A-c>", "<Cmd>BufferClose<CR>")
vim.keymap.set("n", "<A-s-c>", "<Cmd>BufferRestore<CR>")

-- tree-sitter
require("nvim-treesitter").setup({
	install_dir = vim.fn.stdpath("data") .. "/site",
})

require("nvim-treesitter").install({ "python", "cpp", "vim", "lua", "markdown", "c", "cuda", "tablegen" })

vim.api.nvim_create_autocmd("FileType", {
	callback = function()
		pcall(vim.treesitter.start)
		vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
	end,
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

	mapping = {
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				cmp_ultisnips_mappings.expand_or_jump_forwards(fallback)
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				cmp_ultisnips_mappings.jump_backwards(fallback)
			end
		end, { "i", "s" }),
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				local entry = cmp.get_selected_entry()
				if not entry then
					cmp.abort()
					fallback()
					return
				end
				local is_snippet = entry.source.name == "ultisnips" or entry.source.name == "vim-snippets"
				local in_snippet = vim.fn["UltiSnips#CanJumpForwards"]() == 1
					or vim.fn["UltiSnips#CanJumpBackwards"]() == 1
				cmp.confirm({ select = false })
				if in_snippet and not is_snippet then
					vim.defer_fn(function()
						if vim.fn["UltiSnips#CanJumpForwards"]() == 1 then
							vim.fn["UltiSnips#JumpForwards"]()
						end
					end, 0)
				end
			else
				fallback()
			end
		end, { "i", "s" }),
	},

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
		python = { "ruff_format", "ruff_organize_imports" },
		c = { "clang-format" },
		cpp = { "clang-format" },
		cuda = { "clang-format" },
		cmake = { "cmake_format" },
	},
	formatters = {
		["clang-format"] = {
			prepend_args = { "--style=LLVM" },
		},
	},
})
vim.keymap.set("n", "<leader>fr", conform.format, opts)
