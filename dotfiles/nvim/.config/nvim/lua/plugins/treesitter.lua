return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	branch = "main",
	build = ":TSUpdate",
	config = function()
		local ts = require("nvim-treesitter")

		-- 1. Initialize the config (sets up install paths)
		ts.setup()

		-- 2. Define your list of parsers
		local parsers_to_install = {
			"c",
			"cpp",
			"css",
			"dockerfile",
			"gitignore",
			"helm",
			"html",
			"java",
			"javascript",
			"json",
			"jsx",
			"lua",
			"markdown",
			"markdown_inline",
			"python",
			"query",
			"rust",
			"toml",
			"tsx",
			"typescript",
			"vim",
			"vimdoc",
			"yaml",
		}

		-- 3. Create a logic to check and install missing parsers
		local function ensure_installed(languages)
			local installed = ts.get_installed()
			local to_install = {}

			for _, lang in ipairs(languages) do
				-- Using vim.list_contains (Standard in Nvim 0.11+)
				if not vim.list_contains(installed, lang) then
					table.insert(to_install, lang)
				end
			end

			if #to_install > 0 then
				-- Verify the list isn't empty to avoid unnecessary async calls
				-- The second argument is options; explicitly setting force=false
				-- (though it defaults to false in the code you provided)
				ts.install(to_install, { force = false })
			end
		end

		-- 4. Run it
		ensure_installed(parsers_to_install)
	end,
}
