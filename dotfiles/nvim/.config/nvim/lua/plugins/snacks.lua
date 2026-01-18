return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- 1. Beautiful Startup Screen
    dashboard = { enabled = true },

    -- 2. Indent Guides (vertical lines)
    indent = { enabled = false },

    -- 3. Input Box (Rename/Create file UI)
    input = { enabled = true },

    -- 4. Smooth Scrolling (optional, feel free to disable)
    scroll = { enabled = false },

    -- 5. LazyGit Integration (Must have lazygit installed on OS)
    lazygit = { enabled = true },
  },
  keys = {
    -- Open LazyGit floating window
    { "<leader>gg", function() require("snacks").lazygit() end,  desc = "LazyGit" },
    -- Open a normal terminal
    { "<leader>t",  function() require("snacks").terminal() end, desc = "Toggle Terminal" },
  },
}
