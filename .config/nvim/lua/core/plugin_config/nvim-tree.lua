vim.g.loaded_netrw = 1
vim.g.loadednetrwPlugin = 1

require("nvim-tree").setup()

vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')
