vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(args)
    local opts = { buffer = args.buf }
    vim.keymap.set('n', '<Space>lr', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<Space>la', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', '<Space>ld', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', '<Space>li', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<Space>ll', require('telescope.builtin').lsp_references, opts)
    vim.keymap.set('n', '<Space>lh', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', '<Space>lf', vim.lsp.buf.format, opts)
  end,
})

vim.lsp.config('*', {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    }
  },
})

-- Installed servers are enabled automatically by mason-lspconfig
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "bashls",
    "lua_ls",
    "dockerls",
    "docker_compose_language_service",
    "rust_analyzer",
    "terraformls",
    "clangd",
    "marksman",
    "ts_ls",
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
    "kotlin_language_server",
    "yamlls",
    "taplo",
    "gradle_ls",
  },
})
