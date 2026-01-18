return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				lua = { "stylua" },
				python = { "isort", "black" }, -- Run isort first, then black
				java = { "google-java-format" },
				c = { "clang-format" },
				cpp = { "clang-format" },

				-- Use "stop_after_first" to run prettierd if available, otherwise prettier
				javascript = { "prettierd", "prettier", stop_after_first = true },
				typescript = { "prettierd", "prettier", stop_after_first = true },
				javascriptreact = { "prettierd", "prettier", stop_after_first = true },
				typescriptreact = { "prettierd", "prettier", stop_after_first = true },
				css = { "prettierd", "prettier", stop_after_first = true },
				html = { "prettierd", "prettier", stop_after_first = true },
				json = { "prettierd", "prettier", stop_after_first = true },
				jsonc = { "prettierd", "prettier", stop_after_first = true },
				yaml = { "prettierd", "prettier", stop_after_first = true },
				markdown = { "prettierd", "prettier", stop_after_first = true },
				graphql = { "prettierd", "prettier", stop_after_first = true },
			},
			default_format_opts = {
				lsp_format = "fallback",
			},
			format_on_save = function()
				if vim.g.conform_disable then
					return
				end
				return {
					lsp_fallback = true,
					async = false,
					timeout_ms = 1000,
				}
			end,
		})

		-- Commands to enable/disable conform formatting
		vim.api.nvim_create_user_command("ConformEnable", function()
			vim.g.conform_disable = false
			vim.notify("Conform formatting enabled", vim.log.levels.INFO)
		end, {})

		vim.api.nvim_create_user_command("ConformDisable", function()
			vim.g.conform_disable = true
			vim.notify("Conform formatting disabled", vim.log.levels.INFO)
		end, {})
	end,
}
