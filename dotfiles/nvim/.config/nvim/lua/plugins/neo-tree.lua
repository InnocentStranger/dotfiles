return {
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"nvim-tree/nvim-web-devicons",
		},
		lazy = false, -- neo-tree will lazily load itself
		---@module 'neo-tree'
		opts = {
			vim.keymap.set("n", "<leader>e", ":Neotree toggle<CR>", { silent = true }),
			close_if_last_window = true, -- Close Neo-tree if it is the last window left
			filesystem = {
				-- hijack_netrw_behavior = "disabled", -- Prevent Neo-tree from auto-opening on directory launch
				filtered_items = {
					visible = true, -- Show hidden files but grayed out (standard IDE behavior)
					hide_dotfiles = false,
					hide_gitignored = true,
					hide_by_name = {
						"node_modules",
						"thumbs.db",
						".DS_Store",
					},
					never_show = {
						".git",
					},
				},
				follow_current_file = {
					enabled = true, -- Highlight the file you are editing
				},
				use_libuv_file_watcher = true, -- Auto-update tree when files change externally
			},
		},
	},
	{
		"antosha417/nvim-lsp-file-operations",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-neo-tree/neo-tree.nvim", -- makes sure that this loads after Neo-tree.
		},
		config = function()
			require("lsp-file-operations").setup()
		end,
	},
}
