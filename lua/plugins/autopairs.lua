return {
  "windwp/nvim-autopairs",
  version = "v0.6.0",
  event = "InsertEnter",
  config = function()
    local autopairs = require("nvim-autopairs")

    autopairs.setup({
      check_ts = true,      -- Use treesitter for better bracket matching
      ts_config = {
        lua = { "string" }, -- Don't add pairs in lua string treesitter nodes
        javascript = { "template_string" },
        typescript = { "template_string" },
      },
    })

    -- Integrate with nvim-cmp (so completion plays nice with autopairs)
    local cmp_autopairs = require("nvim-autopairs.completion.cmp")
    local cmp = require("cmp")
    cmp.event:on("configure_done", cmp_autopairs.on_configure_done())
  end,
}
