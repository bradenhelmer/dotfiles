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

-- `cmd` as function must return an RPC client (not a command list).
-- Resolve a build-tree binary relative to the project root.
local function project_cmd(bin, args, fallback)
	return function(dispatchers, config)
		local cmd = { bin }
		local root = config.root_dir
		if root then
			local full = root .. "/build/bin/" .. bin
			if vim.fn.executable(full) == 1 then
				cmd = { full }
			elseif fallback then
				cmd = { fallback }
			end
		elseif fallback then
			cmd = { fallback }
		end
		for _, a in ipairs(args) do
			cmd[#cmd + 1] = root and string.gsub(a, "{root}", root) or a
		end
		return vim.lsp.rpc.start(cmd, dispatchers, {
			cwd = config.cmd_cwd,
			env = config.cmd_env,
			detached = config.detached,
		})
	end
end

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
	cmd = function(dispatchers, config)
		local cmd = { "clangd" }
		local root = config.root_dir
		if root and vim.fn.filereadable(root .. "/build/compile_commands.json") == 1 then
			cmd[#cmd + 1] = "--compile-commands-dir=" .. root .. "/build"
		end
		return vim.lsp.rpc.start(cmd, dispatchers, {
			cwd = config.cmd_cwd,
			env = config.cmd_env,
			detached = config.detached,
		})
	end,
	capabilities = capabilities,
	on_attach = on_attach,
})
vim.lsp.enable("clangd")

-- TableGen
vim.lsp.config("tblgen_lsp_server", {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = project_cmd("tblgen-lsp-server", {
		"--tablegen-compilation-database={root}/build/tablegen_compile_commands.yml",
	}, "tblgen-lsp-server-22"),
})
vim.lsp.enable("tblgen_lsp_server")

-- MLIR
-- Set MLIR_LSP_SERVER to a custom dialect build's server binary, e.g.
--   export MLIR_LSP_SERVER=/path/to/cutlass-lsp-server
-- Falls back to mlir-lsp-server-22 on PATH when unset/not executable.
vim.lsp.config("mlir_lsp_server", {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = function(dispatchers, config)
		local bin = os.getenv("MLIR_LSP_SERVER")
		if not (bin and vim.fn.executable(bin) == 1) then
			bin = "mlir-lsp-server-22"
		end
		return vim.lsp.rpc.start({ bin }, dispatchers, {
			cwd = config.cmd_cwd,
			env = config.cmd_env,
			detached = config.detached,
		})
	end,
})
vim.lsp.enable("mlir_lsp_server")


-- Python
vim.lsp.config("basedpyright", {
	capabilities = capabilities,
	on_attach = on_attach,
})
vim.lsp.enable("basedpyright")

-- Mojo
vim.lsp.config("mojo", {
	capabilities = capabilities,
	on_attach = on_attach,
	cmd = function(dispatchers, config)
		local candidates = {
			"/home/bradenhelmer/dev/projects/cfd-lake/.venv/bin/mojo-lsp-server",
		}
		local root = config.root_dir
		if root then
			table.insert(candidates, 1, root .. "/.venv/bin/mojo-lsp-server")
		end
		for _, bin in ipairs(candidates) do
			if vim.fn.executable(bin) == 1 then
				return vim.lsp.rpc.start({ bin, "-I", "src" }, dispatchers, {
					cwd = config.cmd_cwd,
					env = config.cmd_env,
					detached = config.detached,
				})
			end
		end
		vim.notify("mojo-lsp-server not found (looked in " .. table.concat(candidates, ", ") .. ")", vim.log.levels.ERROR)
	end,
})
vim.lsp.enable("mojo")

-- CMake
vim.lsp.enable("neocmake")
