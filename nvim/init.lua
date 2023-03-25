-- Leader, other legacies
vim.g.mapleader = ','
vim.cmd([[ so ~/.config/nvim/legacy.vim ]])

-- tree-stiter
require'nvim-treesitter.configs'.setup {
  sync_install = false,
  ensure_installed = { "python", "cpp", "vim", "lua" }, 
  ignore_install = { "" },
  highlight = {
    enable = true,
    disable = { "" },
    additional_vim_regex_highlighting = false,
  },
 indent = {enable = true, disable = { "yaml" }} 
}

-- Reload change
vim.api.nvim_set_keymap('n', '<leader>so', ':lua vim.cmd([[ so ~/.config/nvim/legacy.vim ]])', { noremap = true, silent = true })
