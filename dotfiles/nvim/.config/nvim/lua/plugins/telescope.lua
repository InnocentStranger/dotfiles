return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		-- optional but recommended
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		local builtin = require("telescope.builtin")

		telescope.setup({
			defaults = {
				-- "smart_case" is default (case insensitive unless you type uppercase)
				path_display = { "truncate" }, -- Clean up long paths

				-- Modern, clean layout configuration
				layout_strategy = "horizontal",
				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					vertical = {
						mirror = false,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 100,
				},

				sorting_strategy = "ascending", -- Results from top to bottom
				prompt_prefix = "   ", -- Requires a Nerd Font
				selection_caret = "  ",
				entry_prefix = "  ",

				mappings = {
					i = {
						["<Esc>"] = actions.close, -- Close on first Esc
					},
				},
			},

			-- Specific adjustments for certain pickers
			pickers = {
				find_files = {
					hidden = true, -- Find .dotfiles by default
				},
				buffers = {
					ignore_current_buffer = true,
					sort_mru = true, -- Sort by most recently used
				},
			},

			-- Extensions setup
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		-- Load FZF extension
		telescope.load_extension("fzf")

		-- Keymaps
		local map = vim.keymap.set
		map("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
		map("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
		map("n", "<leader>fb", builtin.buffers, { desc = "Find Buffers" })
		map("n", "<leader>fh", builtin.help_tags, { desc = "Find Help" })
		map("n", "<leader>fc", builtin.colorscheme, { desc = "Select Colorscheme" })
		map("n", "<leader>fr", builtin.resume, { desc = "Resume Search" })
	end,
}
