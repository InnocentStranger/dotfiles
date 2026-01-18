return {
  {
    "nvim-telescope/telescope-ui-select.nvim",
    config = function()
      -- This is required - you must tell Telescope to load this extension
      require("telescope").setup({
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown({
              -- Standardize the look
              layout_config = {
                width = 0.6,
                height = 0.4,
              },
              border = true,
              previewer = false,
              shorten_path = true,
            }),
          },
        },
      })

      -- Load the extension
      require("telescope").load_extension("ui-select")
    end,
  },
}
