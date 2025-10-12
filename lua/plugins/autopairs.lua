return {
  "windwp/nvim-autopairs",
  version = "v0.6.0",
  event = "InsertEnter",
  config = function()
    require("nvim-autopairs").setup({
      check_ts = true,
      ts_config = {
        lua = { "string" },
        javascript = { "template_string" },
        typescript = { "template_string" },
      },
    })
  end,
}
