return {
	{ "tomiis4/hypersonic.nvim", config = true },
	{
		"Bekaboo/dropbar.nvim",
		config = true,
	},
	{
		"andythigpen/nvim-coverage",
		opts = {
			coverage_file = "coverage/lcov.info",
		},
	},
	{
		"chentoast/marks.nvim",
		opts = {
			default_mappings = true,
			builtin_marks = { ".", "<", ">", "^" },
			sign_priority = { lower = 10, upper = 15, builtin = 8, bookmark = 20 },
			bookmark_0 = {
				sign = "⚑",
				annotate = true,
			},
		},
	},
	{
		"andrewferrier/wrapping.nvim",
		config = true,
	},
	{
		"yamatsum/nvim-nonicons",
		dependencies = { "kyazdani42/nvim-web-devicons" },
		config = function()
			require("config.icons")
		end,
	},
	{
		"yamatsum/nvim-cursorline",
		opts = {
			cursorline = {
				enable = true,
				timeout = 1000,
				number = false,
			},
			cursorword = {
				enable = true,
				min_length = 3,
				hl = { underline = true },
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		config = true,
	},
	{
		"folke/which-key.nvim",
		opts = {
			plugins = {
				spelling = { enabled = true },
				presets = { operators = false },
			},
			window = {
				border = "rounded",
				padding = { 2, 2, 2, 2 },
			},
			disable = { filetypes = { "TelescopePrompt" } },
		},
	},
	{
		"willothy/nvim-cokeline",
		lazy = false,
		config = function()
			local is_picking_focus = require("cokeline.mappings").is_picking_focus
			local is_picking_close = require("cokeline.mappings").is_picking_close
			local palette = require("catppuccin.palettes").get_palette("mocha")

			require("cokeline").setup({
				default_hl = {
					fg = function(buf)
						return buf.is_focused and palette.base or palette.text
					end,
					bg = function(buf)
						return buf.is_focused and palette.subtext1 or palette.base
					end,
				},
				sidebar = {
					filetype = "neo-tree",
					components = {
						{
							text = "    Fabio's Neovim",
							fg = function(buf)
								return buf.is_focused and palette.base or palette.text
							end,
							bg = function(buf)
								return buf.is_focused and palette.text or palette.base
							end,
							style = "bold",
						},
					},
				},
				components = {
					{ text = "  " },
					{
						text = function(buffer)
							return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. " "
								or buffer.devicon.icon
						end,
						fg = function(buffer)
							return (is_picking_focus() and palette.peach)
								or (is_picking_close() and palette.red)
								or buffer.devicon.color
						end,
						style = function(_)
							return (is_picking_focus() or is_picking_close()) and "italic,bold" or nil
						end,
					},
					{
						text = function(buffer)
							return buffer.filename
						end,
						style = "italic",
					},

					{
						text = function(buffer)
							return buffer.is_modified and " *" or ""
						end,
					},
					{ text = "  " },
				},
			})
		end,
		keys = {
			{
				"<S-h>",
				function()
					require("cokeline.mappings").by_step("focus", -1)
				end,
			},
			{
				"<S-l>",
				function()
					require("cokeline.mappings").by_step("focus", 1)
				end,
			},
			{
				"<leader>xf",
				function()
					require("cokeline.mappings").pick("focus")
				end,
			},
			{
				"<leader>xc",
				function()
					require("cokeline.mappings").pick("close")
				end,
			},
		},
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {
			-- space_char_blankline = " ",
			-- show_current_context = true,
			-- show_current_context_start = true,
		},
	},
	{
		"tzachar/highlight-undo.nvim",
		config = true,
	},
	{
		"goolord/alpha-nvim",
		lazy = false,
		config = function()
			-- require("config.alpha")
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
		keys = {
			{ "<leader>a", "<CMD>Alpha<CR>", desc = "Opens Alpha Dashboard" },
		},
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			local notify = require("notify")
			notify.setup({
				render = "compact",
				stages = "slide",
				timeout = 1500,
			})
			vim.notify = notify
		end,
	},
	{
		"mrjones2014/smart-splits.nvim",
		lazy = false,
		config = function()
			-- recommended mappings
			-- resizing splits
			-- these keymaps will also accept a range,
			-- for example `10<A-h>` will `resize_left` by `(10 * config.default_amount)`
			vim.keymap.set("n", "ù", require("smart-splits").resize_left) -- ù is <A-h>
			vim.keymap.set("n", "ú", require("smart-splits").resize_down) -- ú is <A-j>
			vim.keymap.set("n", "ĳ", require("smart-splits").resize_up) -- ĳ is <A-k>
			vim.keymap.set("n", "ø", require("smart-splits").resize_right) -- ø is <A-l>
			-- moving between splits
			vim.keymap.set("n", "<C-h>", require("smart-splits").move_cursor_left)
			vim.keymap.set("n", "<C-j>", require("smart-splits").move_cursor_down)
			vim.keymap.set("n", "<C-k>", require("smart-splits").move_cursor_up)
			vim.keymap.set("n", "<C-l>", require("smart-splits").move_cursor_right)
			-- swapping buffers between windows
			vim.keymap.set("n", "<leader><leader>h", require("smart-splits").swap_buf_left)
			vim.keymap.set("n", "<leader><leader>j", require("smart-splits").swap_buf_down)
			vim.keymap.set("n", "<leader><leader>k", require("smart-splits").swap_buf_up)
			vim.keymap.set("n", "<leader><leader>l", require("smart-splits").swap_buf_right)

			require("smart-splits").setup()
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		config = true,
	},
	{
		"feline-nvim/feline.nvim",
		config = function()
			require("config.statusline")
		end,
	},
	{
		"j-hui/fidget.nvim",
		branch = "legacy",
		config = true,
	},
	{
		"ivanjermakov/troublesum.nvim",
		opts = { enabled = true, autcmd = true, severity_format = { "", "", "󰋼", "󰈾" } },
	},
	{
		"folke/trouble.nvim",
		config = true,
		keys = {
			{ "<leader>lt", "<cmd>TroubleToggle<cr>", desc = "Toggle Diagnostics Window" },
		},
	},
	{
		"gelguy/wilder.nvim",
		dependencies = { "romgrk/fzy-lua-native" },
		config = function()
			require("config.wilder")
		end,
	},
}
