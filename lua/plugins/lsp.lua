return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "b0o/schemastore.nvim",  -- NEW: JSON schemas
    -- Rust-specific enhancements
    {
      "mrcjkb/rustaceanvim",
      version = "^5",
      ft = { "rust" },
    },
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
        border = "rounded",
      },
    })

    -- Diagnostic configuration
    vim.diagnostic.config({
      virtual_text = {
        prefix = "●",
        source = "if_many",
      },
      float = {
        border = "rounded",
        source = "always",
      },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    })

    -- Diagnostic signs
    local signs = { Error = " ", Warn = " ", Hint = "󰌵 ", Info = " " }
    for type, icon in pairs(signs) do
      local hl = "DiagnosticSign" .. type
      vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- LSP keymaps (applied when LSP attaches)
    local on_attach = function(client, bufnr)
      local opts = { buffer = bufnr, silent = true }
      local keymap = vim.keymap.set

      -- Navigation
      keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
      keymap("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
      keymap("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
      keymap("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Show references" }))
      keymap("n", "gt", vim.lsp.buf.type_definition, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

      -- Hover & signature
      keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
      keymap("i", "<C-k>", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))

      -- Actions
      keymap("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
      keymap("n", "<leader>cr", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

      -- Diagnostics
      keymap("n", "<leader>cd", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Line diagnostics" }))
      keymap("n", "[d", vim.diagnostic.goto_prev, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
      keymap("n", "]d", vim.diagnostic.goto_next, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))

      -- Workspace
      keymap("n", "<leader>cwa", vim.lsp.buf.add_workspace_folder, vim.tbl_extend("force", opts, { desc = "Add workspace folder" }))
      keymap("n", "<leader>cwr", vim.lsp.buf.remove_workspace_folder, vim.tbl_extend("force", opts, { desc = "Remove workspace folder" }))
      keymap("n", "<leader>cwl", function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, vim.tbl_extend("force", opts, { desc = "List workspace folders" }))
    end

    -- Capabilities for completion
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    -- Mason-lspconfig bridge
    require("mason-lspconfig").setup({
      ensure_installed = {
        -- JavaScript/TypeScript
        "ts_ls",
        "eslint",
        -- Go
        "gopls",
        -- Lua
        "lua_ls",
        -- DevOps
        "terraformls",
        "dockerls",
        "docker_compose_language_service",
        "yamlls",
        "jsonls",
        -- Markup
        "marksman",
        "html",
        "cssls",
        "emmet_ls",
      },
      automatic_installation = true,
    })

    local lspconfig = require("lspconfig")

    -- TypeScript
    lspconfig.ts_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        typescript = {
          inlayHints = {
            includeInlayParameterNameHints = "all",
            includeInlayParameterNameHintsWhenArgumentMatchesName = false,
            includeInlayFunctionParameterTypeHints = true,
            includeInlayVariableTypeHints = true,
          },
        },
      },
    })

    -- ESLint
    lspconfig.eslint.setup({
      on_attach = function(client, bufnr)
        on_attach(client, bufnr)
        -- Auto-fix on save
        vim.api.nvim_create_autocmd("BufWritePre", {
          buffer = bufnr,
          command = "EslintFixAll",
        })
      end,
      capabilities = capabilities,
    })

    -- Go
    lspconfig.gopls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        gopls = {
          analyses = {
            unusedparams = true,
            shadow = true,
            nilness = true,
            unusedwrite = true,
          },
          staticcheck = true,
          gofumpt = true,
          usePlaceholders = true,
          hints = {
            assignVariableTypes = true,
            compositeLiteralFields = true,
            constantValues = true,
            functionTypeParameters = true,
            parameterNames = true,
            rangeVariableTypes = true,
          },
        },
      },
    })

    -- Rust (using rustaceanvim, don't set up manually)
    -- rustaceanvim handles this automatically

    -- Terraform
    lspconfig.terraformls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Docker
    lspconfig.dockerls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    lspconfig.docker_compose_language_service.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- YAML
    lspconfig.yamlls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        yaml = {
          schemas = {
            ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
            ["https://json.schemastore.org/github-action.json"] = "/action.yml",
            ["https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json"] = "/docker-compose*.yml",
            ["https://json.schemastore.org/chart.json"] = "/Chart.yaml",
            ["https://json.schemastore.org/kustomization.json"] = "/kustomization.yaml",
          },
          validate = true,
          completion = true,
        },
      },
    })

    -- JSON
    lspconfig.jsonls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        json = {
          schemas = require("schemastore").json.schemas(),
          validate = { enable = true },
        },
      },
    })

    -- Lua
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
          telemetry = { enable = false },
          hint = { enable = true },
        },
      },
    })

    -- Markdown
    lspconfig.marksman.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- HTML
    lspconfig.html.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- CSS
    lspconfig.cssls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
    })

    -- Emmet
    lspconfig.emmet_ls.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      filetypes = { "html", "css", "javascriptreact", "typescriptreact" },
    })
  end,
}
