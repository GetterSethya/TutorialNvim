return {
	"nvim-treesitter/nvim-treesitter",
	lazy = true,
	cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = {
				"lua",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"svelte",
				"go",
				"json",
			},
			sync_install = false,
			highlight = { enable = true },
			indent = { enable = true },
			auto_install = true,
		})
	end,
}
