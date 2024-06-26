if vim.g.vscode then
else
	vim.cmd("syntax off")
	require("config.settings")

	-- LAZY setup
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not vim.loop.fs_stat(lazypath) then
		vim.fn.system({
			"git",
			"clone",
			"--filter=blob:none",
			"https://github.com/folke/lazy.nvim.git",
			"--branch=stable", -- latest stable release
			lazypath,
		})
	end
	vim.opt.rtp:prepend(lazypath)

	require("lazy").setup("plugins")

	require("config.keybinds")
	require("config.autocommands")

	vim.cmd("colorscheme catppuccin")

	Msg = function(...)
		require("messages.api").capture_thing(...)
	end
end
require("config.keybinds")
