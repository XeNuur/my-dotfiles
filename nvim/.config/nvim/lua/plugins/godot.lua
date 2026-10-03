return {
	{
		"habamax/vim-godot",
		init = function()
			--Godot exclusive
			local gdproject = io.open(vim.fn.getcwd() .. "/project.godot", "r")
			if gdproject then
				io.close(gdproject)
				vim.fn.serverstart("/tmp/godot.pipe")
				print("listening on godot pipe!")
			end
		end,
	},

	-- GDScript LSP: connects over TCP to the language server running
	-- inside the Godot editor (Editor Settings > Network > Language Server),
	-- so there's no binary for mason to install.
	{
		"neovim/nvim-lspconfig",
		opts = {
			servers = {
				gdscript = { mason = false },
			},
		},
	},
}
