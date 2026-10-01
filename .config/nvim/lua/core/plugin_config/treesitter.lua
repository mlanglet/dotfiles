local treesitter = require('nvim-treesitter')

treesitter.install({ "c", "lua", "rust", "toml" })

-- Start highlighting, installing the parser first when it is missing
vim.api.nvim_create_autocmd('FileType', {
  callback = function(args)
    local lang = vim.treesitter.language.get_lang(args.match)
    if not lang or not vim.tbl_contains(treesitter.get_available(), lang) then
      return
    end
    if vim.tbl_contains(treesitter.get_installed(), lang) then
      vim.treesitter.start(args.buf, lang)
      return
    end
    treesitter.install(lang):await(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        pcall(vim.treesitter.start, args.buf, lang)
      end
    end)
  end,
})
