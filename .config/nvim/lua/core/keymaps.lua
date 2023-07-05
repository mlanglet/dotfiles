local keymap = vim.api.nvim_set_keymap
local default_opts = { noremap = true, silent = true }

keymap('n', '<C-h>', ':HopWord<CR>', default_opts)

keymap('i', 'jk', '<ESC>', default_opts)
keymap('t', 'jk', '<C-\\><C-n>', default_opts)
