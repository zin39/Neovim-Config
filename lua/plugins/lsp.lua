return {
  "neovim/nvim-lspconfig",
  version = "v1.4.0",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  config = function()
    -- Mason setup
    require("mason").setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    -- LSP keymaps
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }

      vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
      vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
      vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
      vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
      vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
      vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    end

    -- Capabilities for completion
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Mason-lspconfig bridge
    require("mason-lspconfig").setup({
      ensure_installed = {
        "ts_ls",
        "eslint",
        "lua_ls",
        "marksman",
      },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")

    -- Configure TypeScript
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Configure Marksman for Markdown
    lspconfig.marksman.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Configure HTML
    lspconfig.html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Configure Emmet
    lspconfig.emmet_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "html", "css" },
    })

    -- Configure ESLint
    lspconfig.eslint.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Configure Lua
    lspconfig.lua_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file("", true),
            checkThirdParty = false,
          },
        },
      },
    })
  end,
}
