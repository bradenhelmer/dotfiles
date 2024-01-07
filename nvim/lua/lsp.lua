-- LSP Management
local lspconfig = require('lspconfig')
local util = lspconfig.util

-- Keymaps
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {

    group = vim.api.nvim_create_augroup("UserLspConfig", {}),

    callback = function(ev)
        vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

        local opts = { noremap = true, silent = true }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
        vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, opts)
        vim.keymap.set({'n', 'v'}, '<Leader>ca', vim.lsp.buf.code_action, opts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
        vim.keymap.set('n', '<Leader>ff', function() vim.lsp.buf.format { async = true} end, opts)
    end
})

-- CCLS
lspconfig.ccls.setup{
    filetypes = {
        "c",
        "cc",
        "cu",
        "cpp",
        "c++",
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
    root_dir = util.root_pattern('compile_commands.json', '.ccls')

}

-- TableGen
lspconfig.tblgen_lsp_server.setup{}

