return {
	{
		"lewis6991/gitsigns.nvim",
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged = {
					add = { text = "┃" },
					change = { text = "┃" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
					untracked = { text = "┆" },
				},
				signs_staged_enable = true,
				signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
				numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
				linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
				word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
				watch_gitdir = {
					follow_files = true,
				},
				auto_attach = true,
				attach_to_untracked = false,
				current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
					delay = 1000,
					ignore_whitespace = false,
					virt_text_priority = 100,
				},
				current_line_blame_formatter = "<author>, <author_time:%R> - <summary>",
				sign_priority = 6,
				update_debounce = 100,
				status_formatter = nil, -- Use default
				max_file_length = 40000, -- Disable if file is longer than this (in lines)
				preview_config = {
					-- Options passed to nvim_open_win
					border = "single",
					style = "minimal",
					relative = "cursor",
					row = 0,
					col = 1,
				},
			})

			local opts = { noremap = true, silent = true }

			-- preview_hunk_inline
			vim.keymap.set("n", "<leader>gh", "<cmd> Gitsigns preview_hunk_inline<CR>", opts)

			-- preview floating
			vim.keymap.set("n", "<leader>gH", "<cmd> Gitsigns preview_hunk<CR>", opts)

			-- toggle line blame
			vim.keymap.set("n", "<leader>gb", "<cmd> Gitsigns toggle_current_line_blame<CR>", opts)
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim", -- required
			"sindrets/diffview.nvim", -- optional - Diff integration

			-- Only one of these is needed, not both.
			"nvim-telescope/telescope.nvim", -- optional
		},

		-- trigger when space gt press
		keys = {
			{ "<leader>gt", "<cmd>Neogit<CR>" },
		},
		config = function()
			local neogit = require("neogit")

			neogit.setup({
				disable_hint = false,
				disable_context_highlighting = false,
				disable_signs = false,
				disable_insert_on_commit = "auto",
				filewatcher = {
					interval = 1000,
					enabled = true,
				},
				graph_style = "ascii",
				git_services = {
					["github.com"] = "https://github.com/${owner}/${repository}/compare/${branch_name}?expand=1",
					["bitbucket.org"] = "https://bitbucket.org/${owner}/${repository}/pull-requests/new?source=${branch_name}&t=1",
					["gitlab.com"] = "https://gitlab.com/${owner}/${repository}/merge_requests/new?merge_request[source_branch]=${branch_name}",
				},
				telescope_sorter = function()
					return require("telescope").extensions.fzf.native_fzf_sorter()
				end,
				remember_settings = true,
				use_per_project_settings = true,
				ignored_settings = {
					"NeogitPushPopup--force-with-lease",
					"NeogitPushPopup--force",
					"NeogitPullPopup--rebase",
					"NeogitCommitPopup--allow-empty",
					"NeogitRevertPopup--no-edit",
				},
				highlight = {
					italic = true,
					bold = true,
					underline = true,
				},
				use_default_keymaps = true,
				auto_refresh = true,
				sort_branches = "-committerdate",
				kind = "tab",
				disable_line_numbers = true,
				console_timeout = 2000,
				auto_show_console = true,
				status = {
					recent_commit_count = 10,
				},
				commit_editor = {
					kind = "auto",
				},
				commit_select_view = {
					kind = "tab",
				},
				commit_view = {
					kind = "vsplit",
					verify_commit = os.execute("which gpg") == 0,
				},
				log_view = {
					kind = "tab",
				},
				rebase_editor = {
					kind = "auto",
				},
				reflog_view = {
					kind = "tab",
				},
				merge_editor = {
					kind = "auto",
				},
				tag_editor = {
					kind = "auto",
				},
				preview_buffer = {
					kind = "split",
				},
				popup = {
					kind = "split",
				},
				signs = {
					hunk = { "", "" },
					item = { ">", "v" },
					section = { ">", "v" },
				},
				integrations = {
					telescope = true,
					diffview = nil,
					fzf_lua = nil,
				},
				sections = {
					sequencer = {
						folded = false,
						hidden = false,
					},
					untracked = {
						folded = false,
						hidden = false,
					},
					unstaged = {
						folded = false,
						hidden = false,
					},
					staged = {
						folded = false,
						hidden = false,
					},
					stashes = {
						folded = true,
						hidden = false,
					},
					unpulled_upstream = {
						folded = true,
						hidden = false,
					},
					unmerged_upstream = {
						folded = false,
						hidden = false,
					},
					unpulled_pushRemote = {
						folded = true,
						hidden = false,
					},
					unmerged_pushRemote = {
						folded = false,
						hidden = false,
					},
					recent = {
						folded = true,
						hidden = false,
					},
					rebase = {
						folded = true,
						hidden = false,
					},
				},
				mappings = {
					commit_editor = {
						["q"] = "Close",
						["<c-c><c-c>"] = "Submit",
						["<c-c><c-k>"] = "Abort",
					},
					commit_editor_I = {
						["<c-c><c-c>"] = "Submit",
						["<c-c><c-k>"] = "Abort",
					},
					rebase_editor = {
						["p"] = "Pick",
						["r"] = "Reword",
						["e"] = "Edit",
						["s"] = "Squash",
						["f"] = "Fixup",
						["x"] = "Execute",
						["d"] = "Drop",
						["b"] = "Break",
						["q"] = "Close",
						["<cr>"] = "OpenCommit",
						["gk"] = "MoveUp",
						["gj"] = "MoveDown",
						["<c-c><c-c>"] = "Submit",
						["<c-c><c-k>"] = "Abort",
						["[c"] = "OpenOrScrollUp",
						["]c"] = "OpenOrScrollDown",
					},
					rebase_editor_I = {
						["<c-c><c-c>"] = "Submit",
						["<c-c><c-k>"] = "Abort",
					},
					finder = {
						["<cr>"] = "Select",
						["<c-c>"] = "Close",
						["<esc>"] = "Close",
						["<c-n>"] = "Next",
						["<c-p>"] = "Previous",
						["<down>"] = "Next",
						["<up>"] = "Previous",
						["<tab>"] = "MultiselectToggleNext",
						["<s-tab>"] = "MultiselectTogglePrevious",
						["<c-j>"] = "NOP",
					},
					-- Setting any of these to `false` will disable the mapping.
					popup = {
						["?"] = "HelpPopup",
						["A"] = "CherryPickPopup",
						["D"] = "DiffPopup",
						["M"] = "RemotePopup",
						["P"] = "PushPopup",
						["X"] = "ResetPopup",
						["Z"] = "StashPopup",
						["b"] = "BranchPopup",
						["B"] = "BisectPopup",
						["c"] = "CommitPopup",
						["f"] = "FetchPopup",
						["l"] = "LogPopup",
						["m"] = "MergePopup",
						["p"] = "PullPopup",
						["r"] = "RebasePopup",
						["v"] = "RevertPopup",
						["w"] = "WorktreePopup",
					},
					status = {
						["k"] = "MoveUp",
						["j"] = "MoveDown",
						["q"] = "Close",
						["o"] = "OpenTree",
						["I"] = "InitRepo",
						["1"] = "Depth1",
						["2"] = "Depth2",
						["3"] = "Depth3",
						["4"] = "Depth4",
						["<tab>"] = "Toggle",
						["x"] = "Discard",
						["s"] = "Stage",
						["S"] = "StageUnstaged",
						["<c-s>"] = "StageAll",
						["K"] = "Untrack",
						["u"] = "Unstage",
						["U"] = "UnstageStaged",
						["$"] = "CommandHistory",
						["Y"] = "YankSelected",
						["<c-r>"] = "RefreshBuffer",
						["<enter>"] = "GoToFile",
						["<c-v>"] = "VSplitOpen",
						["<c-x>"] = "SplitOpen",
						["<c-t>"] = "TabOpen",
						["{"] = "GoToPreviousHunkHeader",
						["}"] = "GoToNextHunkHeader",
						["[c"] = "OpenOrScrollUp",
						["]c"] = "OpenOrScrollDown",
					},
				},
			})

			vim.keymap.set("n", "<leader>gt", "<cmd>Neogit<CR>", { noremap = true, silent = true })
		end,
	},
}
