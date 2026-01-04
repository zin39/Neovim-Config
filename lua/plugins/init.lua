-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Configure lazy.nvim
require("lazy").setup({
  spec = {
    { import = "plugins.ui" },
    { import = "plugins.treesitter" },
    { import = "plugins.lsp" },
    { import = "plugins.completion" },
    { import = "plugins.tools" },
    { import = "plugins.formatting" },
    { import = "plugins.autopairs" },
    { import = "plugins.git" },        -- NEW
    { import = "plugins.terminal" },   -- NEW
    { import = "plugins.extras" },     -- NEW
    { import = "plugins.dap" },        -- NEW
  },
  defaults = {
    lazy = true,  -- CHANGED: Enable lazy loading by default
    version = false,
  },
  install = {
    colorscheme = { "catppuccin" },  -- CHANGED
  },
  checker = {
    enabled = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
        "netrwPlugin",  -- ADDED: Disable netrw since we use neo-tree
      },
    },
  },
})
