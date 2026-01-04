return {
  -- Git signs in gutter
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "│" },
          change = { text = "│" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
          untracked = { text = "┆" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false,  -- Toggle with <leader>gB
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol",
          delay = 500,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns
          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]h", function()
            if vim.wo.diff then return "]h" end
            vim.schedule(function() gs.next_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Next hunk" })

          map("n", "[h", function()
            if vim.wo.diff then return "[h" end
            vim.schedule(function() gs.prev_hunk() end)
            return "<Ignore>"
          end, { expr = true, desc = "Previous hunk" })

          -- Actions
          map("n", "<leader>ghs", gs.stage_hunk, { desc = "Stage hunk" })
          map("n", "<leader>ghr", gs.reset_hunk, { desc = "Reset hunk" })
          map("v", "<leader>ghs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Stage hunk" })
          map("v", "<leader>ghr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, { desc = "Reset hunk" })
          map("n", "<leader>ghS", gs.stage_buffer, { desc = "Stage buffer" })
          map("n", "<leader>ghu", gs.undo_stage_hunk, { desc = "Undo stage hunk" })
          map("n", "<leader>ghR", gs.reset_buffer, { desc = "Reset buffer" })
          map("n", "<leader>ghp", gs.preview_hunk, { desc = "Preview hunk" })
          map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, { desc = "Blame line" })
          map("n", "<leader>gB", gs.toggle_current_line_blame, { desc = "Toggle line blame" })
          map("n", "<leader>ghd", gs.diffthis, { desc = "Diff this" })
          map("n", "<leader>ghD", function() gs.diffthis("~") end, { desc = "Diff this ~" })

          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", { desc = "Select hunk" })
        end,
      })
    end,
  },

  -- Neogit - Magit-like git interface
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "nvim-telescope/telescope.nvim",
    },
    cmd = "Neogit",
    keys = {
      { "<leader>gg", "<cmd>Neogit<cr>", desc = "Open Neogit" },
      { "<leader>gC", "<cmd>Neogit commit<cr>", desc = "Git commit" },
      { "<leader>gp", "<cmd>Neogit push<cr>", desc = "Git push" },
      { "<leader>gP", "<cmd>Neogit pull<cr>", desc = "Git pull" },
    },
    config = function()
      require("neogit").setup({
        disable_hint = false,
        disable_context_highlighting = false,
        disable_signs = false,
        graph_style = "ascii",
        integrations = {
          telescope = true,
          diffview = true,
        },
        sections = {
          untracked = {
            folded = false,
          },
          unstaged = {
            folded = false,
          },
          staged = {
            folded = false,
          },
          stashes = {
            folded = true,
          },
          recent = {
            folded = true,
          },
        },
      })
    end,
  },

  -- Diffview for side-by-side diffs
  {
    "sindrets/diffview.nvim",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles", "DiffviewFileHistory" },
    keys = {
      { "<leader>gd", "<cmd>DiffviewOpen<cr>", desc = "Open diffview" },
      { "<leader>gD", "<cmd>DiffviewClose<cr>", desc = "Close diffview" },
      { "<leader>gf", "<cmd>DiffviewFileHistory %<cr>", desc = "File history" },
      { "<leader>gF", "<cmd>DiffviewFileHistory<cr>", desc = "Repo history" },
    },
    config = function()
      require("diffview").setup({
        diff_binaries = false,
        enhanced_diff_hl = true,
        use_icons = true,
        view = {
          default = {
            layout = "diff2_horizontal",
          },
          merge_tool = {
            layout = "diff3_horizontal",
          },
          file_history = {
            layout = "diff2_horizontal",
          },
        },
      })
    end,
  },
}
