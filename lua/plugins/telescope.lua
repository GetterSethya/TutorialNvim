return {
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.6',
		lazy = true,
		cmd = "Telescope",
        dependencies = { 'nvim-lua/plenary.nvim' },
        config = function()
            -- tambahin variable builtin
            local builtin = require("telescope.builtin")

            -- cari file
            vim.keymap.set('n', '<leader>ff', builtin.find_files, {})

            -- cari keyword (grep) di semua file
            vim.keymap.set('n', '<leader>fw', builtin.live_grep, {})

            -- cari keyword di buffer yang terbuka
            vim.keymap.set('n', '<leader>fb', builtin.buffers, {})

            -- cari keyword di help page
            vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

            -- cari semua, show hidden file
            vim.keymap.set('n', '<leader>fa', "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", {})

            -- cari keyword di buffer saat ini
            vim.keymap.set('n', '<leader>fz', "<cmd> Telescope current_buffer_fuzzy_find <CR>", {})
        end
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        config = function()
            require("telescope").setup {
              extensions = {
                ["ui-select"] = {
                  require("telescope.themes").get_dropdown {}
                }
              }
            }
            require("telescope").load_extension("ui-select")
        end
    },
}
