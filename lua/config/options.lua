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

-- Disable swapfile and backup files
opt.swapfile = false
opt.backup = false
opt.writebackup = false

-- Better completion experience
opt.completeopt = "menu,menuone,noselect"

-- Folding configuration (for treesitter folding)
opt.foldmethod = "expr"
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99  -- Start with all folds open
opt.foldlevelstart = 99

-- Better scroll context
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Show substitution preview
opt.inccommand = "split"
