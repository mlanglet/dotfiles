local rename = '<Space>lr'
local code_actions = '<Space>la'
local definition = '<Space>ld'
local imlpementation = '<Space>li'
local references = '<Space>ll'
local hover = '<Space>lh'
local format = '<Space>lf'

local on_attach = function(_, _)
  vim.keymap.set('n', rename, vim.lsp.buf.rename, {})
  vim.keymap.set('n', code_actions, vim.lsp.buf.code_action, {})
  vim.keymap.set('n', definition, vim.lsp.buf.definition, {})
  vim.keymap.set('n', imlpementation, vim.lsp.buf.imlpementation, {})
  vim.keymap.set('n', references, require('telescope.builtin').lsp_references, {})
  vim.keymap.set('n', hover, vim.lsp.buf.hover, {})
  vim.keymap.set('n', format, vim.lsp.buf.format, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

local rt = require("rust-tools")
local handlers = {
  function(server_name)
    require("lspconfig")[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end,
  ["rust_analyzer"] = function()
    rt.setup {
      server = {
        on_attach = function(_, bufnr)
          vim.keymap.set("n", hover, rt.hover_actions.hover_actions, { buffer = bufnr })
          vim.keymap.set("n", code_actions, rt.code_action_group.code_action_group, { buffer = bufnr })
          vim.keymap.set('n', format, vim.lsp.buf.format, {})
          vim.keymap.set('n', rename, vim.lsp.buf.rename, {})
          vim.keymap.set('n', definition, vim.lsp.buf.definition, {})
          vim.keymap.set('n', imlpementation, vim.lsp.buf.imlpementation, {})
          vim.keymap.set('n', references, require('telescope.builtin').lsp_references, {})
        end,
        capabilities = capabilities,
      }
    }
  end,
  ["lua_ls"] = function()
    require('lspconfig').lua_ls.setup {
      server = {
        on_attach = on_attach,
        capabilities = capabilities,
      },
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
      single_file_support = true,
    }
  end,
}

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
  handlers = handlers,
})
