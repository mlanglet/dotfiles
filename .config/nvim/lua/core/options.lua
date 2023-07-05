
vim.opt.showcmd = true
vim.opt.shiftwidth = 2
vim.opt.shiftround = true
vim.opt.expandtab = true
vim.opt.tabstop = 2

vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
vim.opt.shortmess = vim.opt.shortmess + { c = true }
vim.api.nvim_set_option('updatetime', 300)


-- Check if I want these 
-- vim.g.mapleader = ' '
-- vim.g.maplocalleader = ' '
-- vim.opt.backspace = '2'
-- vim.opt.laststatus = 2
-- vim.opt.autowrite = true
-- vim.opt.autoread = true
