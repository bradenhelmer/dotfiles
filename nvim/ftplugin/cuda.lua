-- CUDA filetype settings
-- Ensure 4 space indentation
vim.opt_local.tabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.softtabstop = 4
vim.opt_local.expandtab = true

-- Format options for CUDA files (with block comments)
vim.opt_local.formatoptions = { j = true, c = true, q = true, l = true, r = true, o = true }
