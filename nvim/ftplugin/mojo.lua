vim.api.nvim_set_keymap('n', '<leader>lr', ":LspRestart mojo<CR>", { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>st', ":LspStart mojo<CR>", { noremap = true, silent = true})
vim.api.nvim_set_keymap('n', '<leader>fr', ":!mojo format %<CR><CR>", { noremap = true, silent = true})
