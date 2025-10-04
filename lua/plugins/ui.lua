return {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    version = "v4.8.0",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme tokyonight-night]])
    end,
  },

  -- Statusline
  {
    "nvim-lualine/lualine.nvim",
    version = "compat-nvim-0.6",
    config = function()
      require("lualine").setup({
        options = {
          theme = "tokyonight",
          section_separators = "",
          component_separators = "",
        },
      })
    end,
  },
}
