-- core keymaps that work wihtout plugins
-- Leader key must be set before lazy.nvim loads
--


vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

-- General Keymaps
keymap.set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- Windows management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "make splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

-- Navigate between splits
keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window" })
keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window" })
keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window" })
keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window" })

-- Buffer navigaiton
keymap.set("n", "<S-h>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
keymap.set("n", "<S-l>", "<cmd>bnext<CR>", { desc = "Next buffer" })

--Better indenting
keymap.set("v", "<", "<gv", { desc = "Indent left" })
keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Move text up and down
keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move text down" })
keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move text up" })

-- Better paste (doesn't replcae clipboard when pasting over selection)
keymap.set("x", "<leader>p", [["_dP]], { desc = "Paste without yanking" })

-- Save and quit keybindings
keymap.set("n", "<C-s>", "<cmd>w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Save file" })
keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Quit window" })
keymap.set("n", "<leader>Q", "<cmd>qa<CR>", { desc = "Quit all" })
keymap.set("n", "<leader>wq", "<cmd>wq<CR>", { desc = "Save and quit" })
keymap.set("n", "<leader>x", "<cmd>x<CR>", { desc = "Save and quit" })

-- Terminal management
keymap.set("n", "<leader>tv", "<cmd>vsplit | terminal<CR>", { desc = "Terminal vertical split" })
keymap.set("n", "<leader>th", "<cmd>split | terminal<CR>", { desc = "Terminal horizontal split" })
keymap.set("n", "<leader>tt", "<cmd>tabnew | terminal<CR>", { desc = "Terminal in new tab" })

-- Terminal mode navigation (escape terminal mode easily)
keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h", { desc = "Go to left window from terminal" })
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j", { desc = "Go to bottom window from terminal" })
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k", { desc = "Go to top window from terminal" })
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l", { desc = "Go to right window from terminal" })

-- Buffer mode management
-- Buffer management keymaps
-- Add this to your keymaps file

-- Function to delete buffer while preserving window layout
local function smart_buffer_delete()
  local current_buf = vim.api.nvim_get_current_buf()

  -- Get list of all buffers
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })

  -- If this is the only buffer, create a new empty one
  if #buffers == 1 then
    vim.cmd("enew")
    vim.api.nvim_buf_delete(current_buf, { force = false })
    return
  end

  -- Find an alternative buffer to switch to
  local alt_buf = nil
  for _, buf in ipairs(buffers) do
    if buf.bufnr ~= current_buf then
      alt_buf = buf.bufnr
      break
    end
  end

  -- Switch to alternative buffer, then delete the original
  if alt_buf then
    vim.api.nvim_set_current_buf(alt_buf)
    -- Use pcall to catch errors (e.g., modified buffer)
    local success, err = pcall(vim.api.nvim_buf_delete, current_buf, { force = false })
    if not success then
      -- If buffer is modified, warn user
      vim.notify("Buffer has unsaved changes. Save or use :bd! to force delete.", vim.log.levels.WARN)
      vim.api.nvim_set_current_buf(current_buf) -- Switch back
    end
  end
end

-- Function to close all buffers except current
local function close_all_except_current()
  local current_buf = vim.api.nvim_get_current_buf()
  local buffers = vim.fn.getbufinfo({ buflisted = 1 })

  for _, buf in ipairs(buffers) do
    if buf.bufnr ~= current_buf then
      -- Try to delete, but don't force (respects modified buffers)
      pcall(vim.api.nvim_buf_delete, buf.bufnr, { force = false })
    end
  end
end

-- Set the keybindings
keymap.set("n", "<leader>bd", smart_buffer_delete, { desc = "Delete buffer (keep windows)" })
keymap.set("n", "<leader>bc", close_all_except_current, { desc = "Close all buffers except current" })
keymap.set("n", "<leader>bb", "<cmd>Telescope buffers<CR>", { desc = "Pick buffer" })
