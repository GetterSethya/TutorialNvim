return {
	"nvim-tree/nvim-tree.lua",
	lazy = true,
	keys = {
		{ "<leader>e", "<cmd> NvimTreeFocus <CR>" },
		{ "<C-n>", "<cmd> NvimTreeToggle <CR>" },
	},
	version = "*",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("nvim-tree").setup({})

		-- toggle file tree
		-- vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", {})

		-- focus
		-- vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { noremap = true, silent = true })
	end,
}
