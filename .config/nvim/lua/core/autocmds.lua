
if vim.fn.has "nvim-0.7" then
  vim.api.nvim_create_autocmd(
    {"BufWritePre"},
    {
      pattern = {"*.rs", "*.go", "*.kt", "*.js", "*.jsx", "*.ts", "*.tsx"},
      callback = function()
        vim.lsp.buf.format()
      end
    })
end
