-- Core Neovim options
-- These settings work with zero plugins installed

local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs and indentation
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

-- Line wrapping
opt.wrap = false

-- Search settings
opt.ignorecase = true
opt.smartcase = true

-- Cursor line
opt.cursorline = true

-- Appearance
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"

-- Backspace behavior
opt.backspace = "indent,eol,start"

-- Clipboard - use system clipboard
opt.clipboard:append("unnamedplus")

-- Split windows
opt.splitright = true
opt.splitbelow = true

-- Persistent undo
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/undo"

-- Faster completion
opt.updatetime = 250
opt.timeoutlen = 300

-- Disable swapfile
opt.swapfile = false

-- Better completion experience
opt.completeopt = "menu,menuone,noselect"
