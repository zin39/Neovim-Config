return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        ensure_installed = {
          -- Existing
          "lua", "vim", "vimdoc",
          "typescript", "tsx", "javascript",
          "json", "html", "css",
          "markdown", "markdown_inline",
          "yaml", "bash",
          -- NEW languages
          "rust",
          "go", "gomod", "gowork", "gosum",
          "terraform", "hcl",
          "dockerfile",
          "toml",
          "regex",
          "gitcommit", "gitignore", "diff",
        },
        auto_install = true,  -- CHANGED: Auto-install missing parsers
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = {
          enable = true,
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
        },
        -- NEW: Text objects configuration
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- Function text objects
              ["af"] = { query = "@function.outer", desc = "Select outer function" },
              ["if"] = { query = "@function.inner", desc = "Select inner function" },
              -- Class text objects
              ["ac"] = { query = "@class.outer", desc = "Select outer class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner class" },
              -- Parameter/argument text objects
              ["aa"] = { query = "@parameter.outer", desc = "Select outer argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner argument" },
              -- Conditional text objects
              ["ai"] = { query = "@conditional.outer", desc = "Select outer conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner conditional" },
              -- Loop text objects
              ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
              -- Comment text object
              ["a/"] = { query = "@comment.outer", desc = "Select outer comment" },
            },
          },
          move = {
            enable = true,
            set_jumps = true,
            goto_next_start = {
              ["]f"] = { query = "@function.outer", desc = "Next function start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]a"] = { query = "@parameter.inner", desc = "Next argument" },
            },
            goto_next_end = {
              ["]F"] = { query = "@function.outer", desc = "Next function end" },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@function.outer", desc = "Previous function start" },
              ["[c"] = { query = "@class.outer", desc = "Previous class start" },
              ["[a"] = { query = "@parameter.inner", desc = "Previous argument" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@function.outer", desc = "Previous function end" },
              ["[C"] = { query = "@class.outer", desc = "Previous class end" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>a"] = { query = "@parameter.inner", desc = "Swap with next argument" },
            },
            swap_previous = {
              ["<leader>A"] = { query = "@parameter.inner", desc = "Swap with previous argument" },
            },
          },
        },
      })
    end,
  },
}
