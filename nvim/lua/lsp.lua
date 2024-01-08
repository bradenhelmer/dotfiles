-- LSP Management
local lspconfig = require('lspconfig')
local util = require 'lspconfig.util'

-- Keymaps
local opts = { noremap = true, silent = true }
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Format function kept seperate from attach function
function Format()
	vim.lsp.buf.format({
		async = true,
	})
end

vim.api.nvim_set_keymap('n', '<leader>ff', "<cmd>lua Format()<CR>", opts)

function CodeAction()
	vim.lsp.buf.code_action()
end

vim.api.nvim_set_keymap('n', '<leader>ca', "<cmd>lua CodeAction()<CR>", opts)
vim.api.nvim_set_keymap('v', '<leader>ca', "<cmd>lua CodeAction()<CR>", opts)

local on_attach = function(client, buffer)
	vim.api.nvim_buf_set_option(buffer, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

	vim.api.nvim_buf_set_keymap(buffer, 'n', 'gD', "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', 'gd', "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', 'K', "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', 'gi', "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', '<C-k>', "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', '<leader>rn', "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
	vim.api.nvim_buf_set_keymap(buffer, 'n', 'gr', "<cmd>lua vim.lsp.buf.references()<CR>", opts)
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- CCLS
lspconfig.ccls.setup {
	filetypes = {
		"c",
		"cuda",
		"cpp",
		"objc",
		"objcpp",
		"h",
		"inc"
	},
	init_options = {
		cache = {
			directory = "/tmp/ccls"
		}
	},
	capabilities = capabilities,
	on_attach = on_attach
}

-- TableGen
lspconfig.tblgen_lsp_server.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
		"tblgen-lsp-server",
		"--tablegen-compilation-database=build/tablegen_compile_commands.yml"
	}
}

lspconfig.lua_ls.setup {
	capabilities = capabilities,
	on_attach = on_attach
}
