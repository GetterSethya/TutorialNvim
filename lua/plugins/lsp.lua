return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup({
				PATH = "prepend",
			})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lspconfig = require("lspconfig")
			local lsp_capabilities = vim.lsp.protocol.make_client_capabilities()
			local util = require("lspconfig.util")
			lsp_capabilities.textDocument.completion.completionItem.snippetSupport = true
			lsp_capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = true

			-- lsp c (pakai clangd)
			lspconfig.clangd.setup({
				capabilities = lsp_capabilities,
				cmd = {
					"clangd",
					"--fallback-style=webkit",
				},
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = true
				end,
			})

			-- lsp javascript
			lspconfig.ts_ls.setup({
				capabilities = lsp_capabilities,
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = true
				end,
			})

			-- lsp svelte
			lspconfig.svelte.setup({
				capabilities = lsp_capabilities,
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = true
					vim.api.nvim_create_autocmd("BufWritePost", {
						pattern = { "*.js", "*.ts" },
						callback = function(ctx)
							client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
						end,
					})
				end,
			})

			-- lsp go
			lspconfig.gopls.setup({
				capabilities = lsp_capabilities,
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
						},
						staticcheck = true,
						gofumpt = true,
					},
				},
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = true
				end,
			})

			lspconfig.emmet_ls.setup({
				capabilities = lsp_capabilities,
				filetypes = {
					"css",
					"html",
					"javascript",
					"javascriptreact",
					"sass",
					"scss",
					"svelte",
					"typescriptreact",
				},
				init_options = {
					html = {
						options = {
							-- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
							["bem.enabled"] = true,
						},
					},
				},
			})

			lspconfig.html.setup({
				capabilities = lsp_capabilities,
			})
			lspconfig.cssls.setup({
				capabilities = lsp_capabilities,
			})

			-- lsp zig
			lspconfig.zls.setup({
				capabilities = lsp_capabilities,
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = true
				end,
			})

			local opts = { noremap = true, silent = true }

			vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
			vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
			vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
			vim.keymap.set("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)

			vim.keymap.set("n", "<C-p>", vim.diagnostic.goto_prev, opts)
			vim.keymap.set("n", "<A-p>", vim.diagnostic.goto_next, opts)
			vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)

			vim.keymap.set("n", "<C-b>s", vim.lsp.buf.signature_help, opts)
			vim.keymap.set("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, opts)
			vim.keymap.set("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, opts)
			vim.keymap.set("n", "<leader>wl", function()
				print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
			end, opts)
			vim.keymap.set("n", "<leader>D", vim.lsp.buf.type_definition, opts)
			vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
			vim.keymap.set("n", "<leader>E", vim.diagnostic.open_float, opts)
			vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, opts)
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"cssls",
					"html",
					"emmet_ls",
                    "ts_ls@4.3.1",
					"gopls",
					"svelte",
				},
			})
		end,
	},
}
