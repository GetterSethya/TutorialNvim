return {
    "nvimtools/none-ls.nvim",
    config = function()
        local null_ls = require("null-ls")
        -- setting formater yang akan dipakai

        null_ls.setup({
            sources = {
                -- stylua
                null_ls.builtins.formatting.stylua,

                -- prettier
                null_ls.builtins.formatting.prettier.with {
                    filetypes = { "css", "html", "javascript", "typescript", "json", "yaml" },
                    dynamic_command = function()
                        return "prettier"
                    end,
                }
            }
        })


        vim.keymap.set("n","<leader>fm", vim.lsp.buf.format, {})

    end
}
