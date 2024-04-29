return {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    config = function()
        require("nvim-tree").setup({})

        -- toggle file tree
        vim.keymap.set("n", "<C-n>", "<cmd> NvimTreeToggle <CR>", {})

        -- focus
        vim.keymap.set("n", "<leader>e", "<cmd> NvimTreeFocus <CR>", { noremap = true, silent = true })
    end,
}
