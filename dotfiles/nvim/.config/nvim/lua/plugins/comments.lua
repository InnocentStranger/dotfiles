return {
	"folke/ts-comments.nvim",
	opts = {},
	event = "VeryLazy",
	enabled = vim.fn.has("nvim-0.10.0") == 1,

	-- Add your custom shortcuts here
	keys = {
		{ "<leader>/", "gcc", remap = true, desc = "Toggle Comment Line" },
		{ "<leader>/", "gc", mode = "v", remap = true, desc = "Toggle Comment Selection" },
	},
}
