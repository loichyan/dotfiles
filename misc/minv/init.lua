function _G.add_snippet(ft, trig, body)
	local ls = require("luasnip")
	ls.add_snippets(ft, { require("luasnip.util.parser").parse_snippet({ trig = trig }, body) })
end

local colorschemes = {
	---@param minv MiNV
	tokyonight = function(minv)
		minv.builtin.tokyonight.style = "strom"
		minv.builtin.tokyonight.enable = true
	end,
	---@param minv MiNV
	onedark = function(minv)
		local ok, onedark = pcall(require, "onedark")
		if not ok then
			return
		end
		minv.builtin.tokyonight.enable = false
		onedark.setup({})
	end,
}

local function disable_formatting(client)
	client.resolved_capabilities.document_formatting = false
end

---@param minv MiNV
---@return any[]
local function custom(minv)
	local utils = require("minv.utils")

	vim.env["http_proxy"] = vim.env["MY_HTTP_PROXY"]
	vim.env["HTTP_PROXY"] = vim.env["MY_HTTP_PROXY"]
	vim.env["https_proxy"] = vim.env["MY_HTTP_PROXY"]
	vim.env["HTTPS_PROXy"] = vim.env["MY_HTTP_PROXY"]

	-- UI settings
	minv.settings.o.guifont = "JetBrainsMono Nerd Font:h10"
	colorschemes.onedark(minv)

	-- Luasnip
	minv.builtin.luasnip = {
		history = false,
		-- Delete leaved snippets
		region_check_events = "InsertEnter",
		delete_check_events = "InsertLeave",
	}

	-- Keybindings
	minv.keybindings.n:extend({
		-- Buffer
		["<Leader>x"] = { "<Cmd>Bdelete<CR>", "Close buffer" },
		-- Telescope
		["<Leader>f"] = {
			["p"] = { "<Cmd>Telescope projects<CR>", "Search recent projects" },
			["P"] = { "<Cmd>SessionManager load_session<CR>", "Search recent sessions" },
			["t"] = { "<Cmd>TodoTelescope<CR>", "Search TODOs" },
			["n"] = { "<Cmd>Telescope notify<CR>", "Search notifications" },
		},
		-- Git
		["<Leader>g"] = {
			["d"] = { "<Cmd>DiffviewOpen<CR>", "Open diffview" },
			["g"] = { "<Cmd>Neogit kind=split<CR>", "Open neogit" },
		},
	})

	-- Integrate nvim-tree with project.nvim
	minv.builtin.tree.git.ignore = false
	vim.list_extend(minv.builtin.tree.filters.custom, { [[^target$]] })

	-- Cmp sources
	vim.list_extend(minv.builtin.cmp.sources, { { name = "nvim_lsp_signature_help" } })

	-- Autocmds
	vim.list_extend(minv.autocmds.q_to_close, { "notify" })

	-- Bufferline
	minv.builtin.bufferline = vim.tbl_extend("force", minv.builtin.bufferline, {
		close_command = "Bdelete! %d",
		right_mouse_command = "Bdelete! %d",
	})

	-- Dashboard
	table.insert(
		minv.builtin.dashboard.buttons,
		2,
		{ "s", "  Last Session", [[<Cmd>SessionManager load_last_session<CR>]] }
	)
	table.insert(minv.builtin.dashboard.buttons, 4, { "p", "  Recent Projects", "<Cmd>Telescope projects<CR>" })

	-- Treesitters
	minv.builtin.treesitter.ensure_installed = "all"

	-- Lsp servers
	minv.builtin.lsp_installer.ensure_installed = {}

	-- Rust
	minv.builtin.lsp.configs.rust_analyzer = {
		settings = {
			["rust-analyzer"] = {
				experimental = {
					procAttrMacros = true,
				},
			},
		},
	}
	-- Ruler
	utils.autocmd("FileType", "rust", "setlocal cc=80")
	-- Toml
	minv.builtin.lsp.configs.taplo = {}

	-- C/C++
	minv.builtin.lsp.configs.clangd = {}

	-- Lua
	local ok_lua_dev, lua_dev = pcall(require, "lua-dev")
	if ok_lua_dev then
		lua_dev = lua_dev.setup({
			lspconfig = {
				on_attach = function(client, _)
					disable_formatting(client)
				end,
			},
		})
		vim.list_extend(lua_dev.settings["Lua"].workspace.library, { vim.fn.expand("~/.config/nvim/lua") })
		minv.builtin.lsp.configs.sumneko_lua = lua_dev
	end
	minv.builtin.lsp.formatters.stylua = {}

	-- Prettier
	minv.builtin.lsp.formatters.prettier = {}

	-- Web
	minv.builtin.lsp.configs.tsserver = {
		on_attach = function(client, _)
			disable_formatting(client)
		end,
	}
	minv.builtin.lsp.configs.cssls = {
		on_attach = function(client, _)
			disable_formatting(client)
		end,
	}

	-- Nix
	minv.builtin.lsp.configs.rnix = {}

	minv.builtin.lsp.configs.rescriptls = {}

	return {
		{ "ful1e5/onedark.nvim" },
		-------------------------------
		-- Better editing experience --
		-------------------------------
		{
			"windwp/nvim-autopairs",
			config = function()
				require("custom.autopairs").setup()
				require("cmp").event:on("confirm_done", require("nvim-autopairs.completion.cmp").on_confirm_done())
			end,
		},
		{
			"windwp/nvim-ts-autotag",
			config = function()
				require("nvim-treesitter").define_modules({
					autotag = {
						enable = true,
					},
				})
			end,
		},
		{ "famiu/bufdelete.nvim" },
		------------------------
		-- Treesitter modules --
		------------------------
		{
			"andymass/vim-matchup",
			config = function()
				require("nvim-treesitter").define_modules({
					matchup = {
						enable = true,
					},
				})
			end,
		},
		{
			"p00f/nvim-ts-rainbow",
			config = function()
				local c = require("onedark.colors").setup({})
				require("nvim-treesitter").define_modules({
					rainbow = {
						enable = true,
						extended_mode = true,
						colors = {
							c.red0,
							c.yellow0,
							c.blue0,
							c.purple0,
							c.green0,
							c.orange0,
							c.cyan0,
						},
					},
				})
			end,
		},
		{ "tpope/vim-surround" },
		{ "tpope/vim-repeat" },
		{ "tpope/vim-sleuth" },
		-------------------
		-- UI Enhancment --
		-------------------
		{ "hrsh7th/cmp-nvim-lsp-signature-help" },
		{ "nacro90/numb.nvim" },
		{
			"kevinhwang91/nvim-bqf",
			config = function()
				require("bqf").setup({
					func_map = {
						pscrollup = "<C-u>",
						pscrolldown = "<C-d>",
					},
				})
			end,
		},
		{
			"folke/todo-comments.nvim",
			config = function()
				require("todo-comments").setup({})
			end,
		},
		{
			"norcalli/nvim-colorizer.lua",
			config = function()
				require("colorizer").setup({ "*" })
			end,
		},
		{
			"rcarriga/nvim-notify",
			config = function()
				vim.notify = require("notify")
				vim.notify.setup({ max_width = 70 })
				require("telescope").load_extension("notify")
			end,
		},
		{
			"j-hui/fidget.nvim",
			config = function()
				require("fidget").setup({})
			end,
		},
		{
			"lukas-reineke/indent-blankline.nvim",
			config = function()
				require("indent_blankline").setup({
					filetype_exclude = { "alpha", "NvimTree", "", "lspinfo", "toggleterm", "packer" },
					show_current_context = true,
					use_treesitter = true,
				})
			end,
		},
		{
			"stevearc/dressing.nvim",
			config = function()
				require("dressing").setup({})
			end,
		},
		----------------
		-- Git helper --
		----------------
		{
			"TimUntersberger/neogit",
			config = function()
				require("neogit").setup({
					integrations = {
						diffview = true,
					},
				})
			end,
		},
		{
			"sindrets/diffview.nvim",
			config = function()
				local actions = require("diffview.config").actions
				require("diffview").setup({
					enhanced_diff_hl = true,
					file_panel = {
						win_config = {
							width = 30,
						},
					},
					key_bindings = {
						view = {
							["q"] = "<Cmd>DiffviewClose<CR>",
							["<C-b>"] = actions.toggle_files,
							["<C-n>"] = actions.focus_files,
						},
						file_panel = {
							["q"] = "<Cmd>DiffviewClose<CR>",
							["<C-b>"] = actions.toggle_files,
							["<C-n>"] = actions.focus_files,
						},
						file_history_panel = {
							["q"] = "<Cmd>DiffviewClose<CR>",
							["<C-b>"] = actions.toggle_files,
							["<C-n>"] = actions.focus_files,
						},
					},
				})
			end,
		},
		----------
		-- Misc --
		----------
		{ "folke/lua-dev.nvim" },
		{ "direnv/direnv.vim" },
		{
			"ahmedkhalf/project.nvim",
			config = function()
				require("project_nvim").setup({
					ignore_lsp = { "null-ls" },
				})
				require("telescope").load_extension("projects")
			end,
		},
		{
			"Shatur/neovim-session-manager",
			config = function()
				require("session_manager").setup({
					autoload_mode = require("session_manager.config").AutoloadMode.Disabled,
				})
			end,
		},
		{
			"ethanholz/nvim-lastplace",
			disable = true,
			config = function()
				require("nvim-lastplace").setup({})
			end,
		},
	}
end

require("minv").setup(custom)
