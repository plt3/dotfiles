local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

require("lazy").setup({
	"tpope/vim-sleuth",
	"tpope/vim-surround",
	"tpope/vim-repeat",
	"romainl/vim-cool",
	"tpope/vim-fugitive",
	"szw/vim-maximizer",
	"dkarter/bullets.vim",
	"jiangmiao/auto-pairs",
	"unblevable/quick-scope",
	"airblade/vim-rooter",
	"lervag/vimtex",
	"christoomey/vim-tmux-navigator",
	{
		"preservim/vimux",
		-- don't load it in notes script when run with iTerm hotkey window
		cond = function()
			return vim.fn.executable("tmux") == 1
		end,
	},
	"numToStr/Comment.nvim",
	"smoka7/hop.nvim",
	"karb94/neoscroll.nvim",
	{ "sindrets/diffview.nvim", dependencies = "nvim-lua/plenary.nvim" },
	"folke/tokyonight.nvim",
	"nvim-tree/nvim-web-devicons",
	"nvim-lualine/lualine.nvim",
	"hiphish/rainbow-delimiters.nvim",
	"nvim-tree/nvim-tree.lua",
	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.4",
		dependencies = "nvim-lua/plenary.nvim",
	},
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	{
		"danielfalk/smart-open.nvim",
		branch = "0.2.x",
		dependencies = {
			"kkharji/sqlite.lua",
			-- Only required if using match_algorithm fzf
			{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
		},
	},
	"romus204/tree-sitter-manager.nvim",
	"lukas-reineke/indent-blankline.nvim",
	-- LSP Support
	{ "neovim/nvim-lspconfig" },
	{ "williamboman/mason.nvim" },
	{ "williamboman/mason-lspconfig.nvim" },
	-- Autocompletion
	{ "hrsh7th/nvim-cmp" },
	{ "hrsh7th/cmp-buffer" },
	{ "hrsh7th/cmp-path" },
	{ "hrsh7th/cmp-cmdline" },
	{ "saadparwaiz1/cmp_luasnip" },
	{ "hrsh7th/cmp-nvim-lsp" },
	{ "hrsh7th/cmp-nvim-lua" },
	-- Snippets
	{ "L3MON4D3/LuaSnip" },
	{ "rafamadriz/friendly-snippets" },
	"ray-x/lsp_signature.nvim",
	"stevearc/conform.nvim",
	"zapling/mason-conform.nvim",
	"mfussenegger/nvim-dap",
	{ "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } },
	"jay-babu/mason-nvim-dap.nvim",
	"mfussenegger/nvim-jdtls",
	"andrewferrier/debugprint.nvim",
	"epwalsh/obsidian.nvim",
	{
		"NStefan002/2048.nvim",
		cmd = "Play2048",
		config = true,
	},
	"onsails/lspkind.nvim",
	"mfussenegger/nvim-lint",
	{
		"OscarCreator/rsync.nvim",
		build = "make",
		dependencies = "nvim-lua/plenary.nvim",
	},
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			{ "tpope/vim-dadbod", lazy = true },
			{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
		},
		cmd = {
			"DBUI",
			"DBUIToggle",
			"DBUIAddConnection",
			"DBUIFindBuffer",
		},
	},
	{ "gbprod/substitute.nvim" },
	{ "fpob/nette.vim" },
	{ "nvim-treesitter/nvim-treesitter", enabled = false },
	{
		"mistweaverco/kulala.nvim",
		ft = { "http", "rest" },
		opts = {
			global_keymaps = true,
			ui = {
				max_response_size = 1024 * 1024, -- 1MB
				show_request_summary = false,
			}
		},
	},
})
