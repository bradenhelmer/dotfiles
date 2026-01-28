-- LSP Management

-- Set root marker
vim.lsp.config("*", { root_markers = { ".git" } })

-- Keymaps
local opts = { silent = true }
vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
vim.keymap.set("n", "<space>q", vim.diagnostic.setloclist, opts)

vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
vim.keymap.set("v", "<leader>ca", vim.lsp.buf.code_action, opts)

-- LSP Toggler
local LspStatus = true
function ToggleLsp()
	if LspStatus then
		vim.cmd("LspStop")
	else
		vim.cmd("LspStart")
	end
	LspStatus = not LspStatus
end
vim.keymap.set("n", "<leader>ls", ToggleLsp, opts)

local on_attach = function(client, buffer)
	if LspStatus then
		vim.bo[buffer].omnifunc = "v:lua.vim.lsp.omnifunc"

		buffer_opts = { buffer = buffer, silent = true }
		vim.keymap.set("n", "gD", vim.lsp.buf.declaration, buffer_opts)
		vim.keymap.set("n", "gd", vim.lsp.buf.definition, buffer_opts)
		vim.keymap.set("n", "K", vim.lsp.buf.hover, buffer_opts)
		vim.keymap.set("n", "gi", vim.lsp.buf.implementation, buffer_opts)
		vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, buffer_opts)
		vim.keymap.set("n", "gr", vim.lsp.buf.references, buffer_opts)
		vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, buffer_opts)
	end
end

local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- ClangD
vim.lsp.config("clangd", {
	filetypes = {
		"c",
		"cuda",
		"cpp",
		"objc",
		"objcpp",
		"h",
		"inc",
	},
	init_options = {
		cache = {
			directory = "/tmp/ccls",
		},
	},
	root_markers = { "compile_commands.json", ".ccls", "build", ".git" },
	capabilities = capabilities,
	on_attach = on_attach,
})
vim.lsp.enable("clangd")

-- TableGen
vim.lsp.config("tblgen_lsp_server", {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = {
		"tblgen-lsp-server",
		"--tablegen-compilation-database=tablegen_compile_commands.yml",
	},
})
vim.lsp.enable("tblgen_lsp_server")

-- MLIR
vim.lsp.config("mlir_lsp_server", {
	capabilities = capabilities,
	on_attach = on_attach,
})
vim.lsp.enable("mlir_lsp_server")

-- Python
vim.lsp.config("basedpyright", {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {},
})
vim.lsp.enable("basedpyright")

-- Mojo
vim.lsp.config("mojo", {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = { "mojo-lsp-server", "-I", "src" },
})
vim.lsp.enable("mojo")
