vim.api.nvim_set_hl(0, "TSRainbowRed", { fg = "#f38ba8" })
vim.api.nvim_set_hl(0, "TSRainbowYellow", { fg = "#f9e2af" })
vim.api.nvim_set_hl(0, "TSRainbowBlue", { fg = "#89b4fa" })
vim.api.nvim_set_hl(0, "TSRainbowOrange", { fg = "#fab387" })
vim.api.nvim_set_hl(0, "TSRainbowGreen", { fg = "#a6e3a1" })
vim.api.nvim_set_hl(0, "TSRainbowViolet", { fg = "#cba6f7" })
vim.api.nvim_set_hl(0, "TSRainbowCyan", { fg = "#94e2d5" })

require("nvim-treesitter.configs").setup({
	ensure_installed = {
		"typescript",
		"json",
		"javascript",
		"html",
		"markdown",
		"markdown_inline",
		"bash",
		"toml",
		"yaml",
		"dockerfile",
		"gitignore",
		"git_config",
	},
	highlight = {
		enable = true,
	},
	textobjects = {
		select = {
			enable = true,
			lookahead = true,
			keymaps = {
				-- You can use the capture groups defined in textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				-- You can optionally set descriptions to the mappings (used in the desc parameter of
				-- nvim_buf_set_keymap) which plugins like which-key display
				["ic"] = { query = "@class.inner", desc = "Select inner part of a class region" },
			},
			selection_modes = {
				["@parameter.outer"] = "v", -- charwise
				["@function.outer"] = "V", -- linewise
				["@class.outer"] = "<c-v>",
			},
		},
		swap = {
			enable = true,
			swap_next = {
				["<leader>a"] = "@parameter.inner",
			},
			swap_previous = {
				["<leader>A"] = "@parameter.inner",
			},
		},
		move = {
			enable = true,
			set_jumps = true, -- whether to set jumps in the jumplist
			goto_next_start = {
				["]]"] = "@function.outer",
				["]c"] = { query = "@class.outer", desc = "Next class start" },
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
			},
			goto_previous_start = {
				["[["] = "@function.outer",
				["[c"] = "@class.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
			},
		},
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<leader>df"] = "@function.outer",
				["<leader>dF"] = "@class.outer",
			},
		},
	},
	context_commentstring = {
		enable = false,
		enable_autocmd = false,
	},
	rainbow = {
		enable = false,
		disable = { "html" },
		extended_mode = false,
		max_file_lines = nil,
	},
	autotag = {
		enable = true,
	},
	incremental_selection = {
		enable = true,
		keymaps = {
			init_selection = "gnn",
			node_incremental = "grn",
			scope_incremental = "grc",
			node_decremental = "grm",
		},
	},
	indent = {
		enable = true,
	},
})
