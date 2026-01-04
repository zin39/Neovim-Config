return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_fallback = true })
      end,
      mode = { "n", "v" },
      desc = "Format buffer",
    },
  },
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- JavaScript/TypeScript
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        -- Web
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        -- Lua
        lua = { "stylua" },
        -- Rust (rustfmt)
        rust = { "rustfmt" },
        -- Go
        go = { "goimports", "gofumpt" },
        -- Terraform
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
        -- Shell
        sh = { "shfmt" },
        bash = { "shfmt" },
        -- Docker
        dockerfile = { "hadolint" },
      },
      format_on_save = function(bufnr)
        -- Disable autoformat for certain filetypes
        local ignore_filetypes = { "sql", "java" }
        if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
          return
        end
        -- Disable for files in certain paths
        local bufname = vim.api.nvim_buf_get_name(bufnr)
        if bufname:match("/node_modules/") then
          return
        end
        return {
          timeout_ms = 500,
          lsp_fallback = true,
        }
      end,
      -- Formatter-specific settings
      formatters = {
        shfmt = {
          prepend_args = { "-i", "2" },  -- 2 space indent
        },
      },
    })
  end,
}
