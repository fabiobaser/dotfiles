return {
	{
		"https://git.sr.ht/~whynothugo/lsp_lines.nvim",
		config = function()
			require("lsp_lines").setup()
			vim.diagnostic.config({
				virtual_text = false,
			})
		end,
	},
	{
		"themaxmarchuk/tailwindcss-colors.nvim",
		config = true,
	},
	{ "neovim/nvim-lspconfig" },
	{
		"williamboman/mason-lspconfig.nvim",
		priority = 100,
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
			"b0o/schemastore.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"simrat39/inlay-hints.nvim",
		},
		lazy = false,
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup()

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local ih = require("inlay-hints")
			ih.setup()

			require("mason-lspconfig").setup_handlers({
				-- The first entry (without a key) will be the default handler
				-- and will be called for each installed server that doesn't have
				-- a dedicated handler.
				function(server_name) -- default handler (optional)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = function(client)
							client.resolved_capabilities.document_formatting = false
							client.server_capabilities.documentFormattingProvider = false
							client.server_capabilities.documentRangeFormattingProvider = false
							print(vim.inspect(client))
						end,
					})
				end,
				["tsserver"] = function()
					require("lspconfig").tsserver.setup({
						on_attach = function(c, b)
							vim.lsp.inlay_hint(b, true)
							ih.on_attach(c, b)
						end,
						settings = {
							javascript = {
								inlayHints = {
									includeInlayEnumMemberValueHints = true,
									includeInlayFunctionLikeReturnTypeHints = true,
									includeInlayFunctionParameterTypeHints = true,
									includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
									includeInlayParameterNameHintsWhenArgumentMatchesName = false,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayVariableTypeHints = true,
								},
							},
							typescript = {
								inlayHints = {
									includeInlayEnumMemberValueHints = true,
									includeInlayFunctionLikeReturnTypeHints = false,
									includeInlayFunctionParameterTypeHints = false,
									includeInlayParameterNameHints = "all", -- 'none' | 'literals' | 'all';
									includeInlayParameterNameHintsWhenArgumentMatchesName = false,
									includeInlayPropertyDeclarationTypeHints = true,
									includeInlayVariableTypeHints = true,
									includeInlayVariableTypeHintsWhenTypeMatchesName = false,
								},
							},
						},
					})
				end,
				["lua_ls"] = function()
					require("lspconfig").lua_ls.setup({
						settings = {
							Lua = {
								hint = true,
							},
						},
					})
				end,
				["tailwindcss"] = function()
					require("lspconfig").tailwindcss.setup({
						on_attach = function(client, bufnr)
							require("tailwindcss-colors").buf_attach(bufnr)
						end,
					})
				end,
				["jsonls"] = function()
					require("lspconfig").jsonls.setup({
						settings = {
							json = {
								schemas = require("schemastore").json.schemas(),
								validate = { enable = true },
							},
						},
						capabilities = capabilities,
					})
				end,
			})
		end,
		keys = {
			{
				"<leader>uh",
				function()
					vim.lsp.inlay_hint(0, nil)
				end,
				{ desc = "Toggle Inlay Hints" },
			},
		},
	},
	{
		"jose-elias-alvarez/null-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			local formatting = null_ls.builtins.formatting
			local completion = null_ls.builtins.completion

			null_ls.setup({
				sources = {
					formatting.prettierd,
					formatting.stylua,
					null_ls.builtins.code_actions.gitsigns,
					null_ls.builtins.formatting.cljstyle,
				},
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								vim.lsp.buf.format({
									bufnr = bufnr,
									filter = function(client)
										return client.name == "null-ls"
									end,
								})
							end,
						})
					end
				end,
			})
		end,
	},
	{
		"rmagatti/goto-preview",
		config = true,
	},
	{
		"glepnir/lspsaga.nvim",
		event = "LspAttach",
		branch = "main",
		opts = {
			symbol_in_winbar = {
				enable = false,
			},
			lightbulb = {
				sign = false,
			},
			finder = {
				width = 100,
			},
		},
		keys = {
			{ "K", "<cmd>Lspsaga hover_doc<cr>", desc = "Show Doc on Hover" },
			{ "<leader>lf", "<cmd>Lspsaga finder<cr>", desc = "Show Definitions and References" },
			{ "<leader>lr", "<cmd>Lspsaga rename<cr>", desc = "Rename Symbol" },
			{ "<leader>lR", "<cmd>Lspsaga project_replace<cr>", desc = "Replace project wide" },
			{ "<leader>ld", "<cmd>Lspsaga peek_definition<cr>", desc = "Peek Definition" },
			{ "<leader>lD", "<cmd>Lspsaga goto_definition<cr>", desc = "Goto Definition" },
			{ "[e", "<cmd>Lspsaga diagnostic_jump_next<cr>zz", desc = "Jumpt to next Issue" },
			{ "]e", "<cmd>Lspsaga diagnostic_jump_prev<cr>", desc = "Jumpt to prev Issue" },
		},
	},
	{
		"weilbith/nvim-code-action-menu",
		cmd = "CodeActionMenu",
	},
	{ "onsails/lspkind.nvim" },
	{ "codota/tabnine-nvim", build = "./dl_binaries.sh" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				build = "make install_jsregexp",
				dependencies = { "rafamadriz/friendly-snippets" },
				name = "luasnip",
				config = function()
					local lazyLoad = require("luasnip.loaders.from_vscode").lazy_load
					lazyLoad()
					lazyLoad({ paths = { "./snippets" } })
				end,
			},
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-nvim-lua",
			{
				"tzachar/cmp-tabnine",
				build = "./install.sh",
			},
			{
				"KadoBOT/cmp-plugins",
				config = function()
					require("cmp-plugins").setup({
						files = { ".*\\.lua" },
					})
				end,
			},
			"lukas-reineke/cmp-under-comparator",
			"saadparwaiz1/cmp_luasnip",
		},
		config = function()
			require("config.cmp")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
			"HiPhish/nvim-ts-rainbow2",
			"windwp/nvim-ts-autotag",
			"JoosepAlviste/nvim-ts-context-commentstring",
		},
		config = function()
			require("config.ts")
		end,
	},

	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = true,
	},
	{
		"zbirenbaum/copilot-cmp",
		opts = {},
	},
}
