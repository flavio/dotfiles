-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
--
local formatters = require("lvim.lsp.null-ls.formatters")
formatters.setup({
	{ command = "stylua" },
	{
		command = "prettier",
		extra_args = { "--print-width", "100" },
		filetypes = { "typescript", "typescriptreact", "javascript", "javascriptreact", "yaml", "markdown" },
	},
	{ command = "taplo", filetypes = { "toml" } },
	{ command = "goimports", filetypes = { "go" } },
})

lvim.plugins = {
	"Mofiqul/dracula.nvim",
	"tpope/vim-fugitive",
	"duane9/nvim-rg",
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v3.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
	},
	{
		"gbprod/yanky.nvim",
		config = true,
	},
}

lvim.builtin.telescope.on_config_done = function(telescope)
	pcall(telescope.load_extension, "yank_history")
end

lvim.keys.normal_mode["<leader>y"] = "<cmd>Telescope yank_history<cr>"

lvim.colorscheme = "dracula"

lvim.builtin.bufferline.active = false
lvim.builtin.nvimtree.active = false -- NOTE: using neo-tree

lvim.format_on_save = true

-- -- set additional linters
local linters = require("lvim.lsp.null-ls.linters")
linters.setup({
	{ command = "vale", filetypes = { "markdown", "md", "golang", "go" } },
})

-- instruct treestitter to use zig as compiler - required to workaround nixos/opensuse mismatches
require("nvim-treesitter.install").compilers = { "zig" }
