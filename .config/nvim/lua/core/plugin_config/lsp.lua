local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.imlpementation, {})
  vim.keymap.set('n', 'gr', require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "lua_ls",
    "dockerls",
    "docker_compose_language_service",
    "rust_analyzer",
    "terraformls",
    "grammarly",
    "clangd",
    "marksman",
    "tsserver",
    "emmet_ls",
    "cssls",
    "lemminx",
    "gopls",
    "html",
    "jdtls",
    "sqlls",
    "eslint",
    "jsonls",
    "tailwindcss",
    "lua_ls",
    "kotlin_language_server",
    "yamlls",
    "taplo",
    "gradle_ls",
  },
  automatic_installation = true,
  handlers = {
    function (server_name) -- default handler (optional)
      require("lspconfig")[server_name].setup {
        on_attach = on_attach
      }
    end,
    require("lspconfig")["rust_analyzer"].setup {
      on_attach = on_attach,
      capabilities = capabilities
    }      
  }
})


