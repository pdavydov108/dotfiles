local g = vim.g
g.mapleader = ";"
g.maplocalleader = ";"

-- Ensure lazy.nvim is installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- Latest stable release
		lazypath,
	})
end

--- Define vim to avoid diagnostics warning
vim = vim or {}
vim.opt.rtp:prepend(lazypath)

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require("lazy").setup({
	-- Plugin: Treesitter for syntax highlighting
		{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate", -- Run :TSUpdate after installation
		event = { "BufReadPost", "BufNewFile" }, -- Load on file open
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = { "lua", "python", "javascript" },
				highlight = { enable = true },
				auto_install = true,
				ignore_install = {},
					modules = {}, -- Placeholder for required fields
					sync_install = false, -- Placeholder for required fields
			})
		end,
	},
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		---@type snacks.Config
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
			bigfile = { enabled = true },
			dashboard = { enabled = true },
			explorer = { enabled = false },
			indent = { enabled = true },
			input = { enabled = true },
			picker = { enabled = true },
			notifier = { enabled = true },
			quickfile = { enabled = true },
			scope = { enabled = true },
			scroll = { enabled = true },
			statuscolumn = { enabled = true },
			words = { enabled = true },
		},
		keys = {
			{ "<leader>/", function() Snacks.picker.grep() end, desc = "Grep" },
			{ "<leader>gb", function() Snacks.picker.git_branches() end, desc = "Git Branches" },
			{ "<leader>T",      function() Snacks.terminal() end, desc = "Toggle Terminal" },
			{ "<leader>FF", function() Snacks.picker.smart() end, desc = "Smart Find Files" },
			{ "<leader>fr", function() Snacks.picker.lsp_references() end, nowait = true, desc = "References" },
			-- { "gI", function() Snacks.picker.lsp_implementations() end, desc = "Goto Implementation" },
			-- { "gy", function() Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition" },
			{ "<leader>ss", function() Snacks.picker.lsp_symbols() end, desc = "LSP Symbols" },
		},
	},
	{ "alexghergh/nvim-tmux-navigation", config = function()

		local nvim_tmux_nav = require('nvim-tmux-navigation')

		nvim_tmux_nav.setup {
			disable_when_zoomed = true -- defaults to false
		}

		vim.keymap.set('n', "<C-h>", nvim_tmux_nav.NvimTmuxNavigateLeft)
		vim.keymap.set('n', "<C-j>", nvim_tmux_nav.NvimTmuxNavigateDown)
		vim.keymap.set('n', "<C-k>", nvim_tmux_nav.NvimTmuxNavigateUp)
		vim.keymap.set('n', "<C-l>", nvim_tmux_nav.NvimTmuxNavigateRight)
		-- vim.keymap.set('n', "<C-\\>", nvim_tmux_nav.NvimTmuxNavigateLastActive)
		-- vim.keymap.set('n', "<C-Space>", nvim_tmux_nav.NvimTmuxNavigateNext)

		end
	},
	{ "RRethy/vim-illuminate" },
	{
		"ellisonleao/gruvbox.nvim",
		priority = 1000, -- Load Gruvbox before other plugins
		config = function()
			vim.o.background = "dark" -- Set to "dark" or "light" for Gruvbox
			vim.cmd("colorscheme gruvbox")
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("gitsigns").setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "-" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				current_line_blame = true,
			})
		end,
	},
	{
		"NeogitOrg/neogit",
		dependencies = {
			"nvim-lua/plenary.nvim",         -- required
			"sindrets/diffview.nvim",        -- optional - Diff integration
		},
		config = true
	},
	{ "nvim-tree/nvim-web-devicons", opts = {} },
	{
		'nvim-lualine/lualine.nvim',
		dependencies = { 'nvim-tree/nvim-web-devicons' },
		config = function()
			require("lualine").setup({
				options = {
					theme = "gruvbox", -- Select a theme
					section_separators = { left = "", right = "" },
					component_separators = { left = "", right = "" },
				},
				sections = {
					lualine_c = {
						"lsp_progress"
					}
				},
			})
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope-fzf-native.nvim" },
		config = function()
			require("telescope").setup({
				defaults = {
					file_ignore_patterns = { "node_modules" },
					mappings = {
						i = { ["<C-h>"] = "which_key" },
					},
				},
			})
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "make",
	},
	{
		'akinsho/bufferline.nvim',
		event = "BufReadPre",
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		diagnostics = "nvim_lsp",
		config = function()
			require("bufferline").setup()
		end
	},
	{
		"williamboman/mason.nvim",
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"jay-babu/mason-nvim-dap.nvim",
			"neovim/nvim-lspconfig",
		},
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "pyright", "clangd", "rust_analyzer", "lua_ls"},
				automatic_installation = true,
				automatic_enable = true, -- Placeholder for required fields
			})
			require("mason-nvim-dap").setup({
				ensure_installed = { "codelldb", "debugpy"},
				automatic_installation = true
			})
			require("lspconfig").pyright.setup({})
			require("lspconfig").lua_ls.setup({
				settings = {
					Lua = {
						runtime = {
							-- Tell Lua which version you're using (most likely LuaJIT for Neovim)
							version = "LuaJIT",
							pathStrict = false, -- Disable strict path checking
						},
						diagnostics = {
							-- Recognize the `vim` global
							globals = { "vim" },
							checkThirdParty = false,
						},
						workspace = {
							-- Make the server aware of Neovim runtime files
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false, -- Optional: Disable annoying popups for third-party modules
						},
						telemetry = {
							enable = false, -- Disable telemetry to reduce unnecessary network usage
						},
					},
				},
			})
		end,
	},
	{ "rafamadriz/friendly-snippets" },
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",  -- LSP source for nvim-cmp
			"hrsh7th/cmp-buffer",    -- Buffer completions
			"hrsh7th/cmp-path",      -- Path completions
			"hrsh7th/cmp-cmdline",   -- Command-line completions
			"hrsh7th/cmp-nvim-lsp-signature-help",
			"L3MON4D3/LuaSnip",      -- Snippet engine
			"saadparwaiz1/cmp_luasnip", -- Snippet completions
			"onsails/lspkind.nvim",
		},
		event = { "InsertEnter", "CmdlineEnter" },
		config = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			require("luasnip.loaders.from_vscode").lazy_load()
			local lspkind = require("lspkind")

			cmp.setup({
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body) -- Use LuaSnip for snippets
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-b>"] = cmp.mapping.scroll_docs(-4),
					["<C-f>"] = cmp.mapping.scroll_docs(4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping.abort(),
					-- ["<Tab>"] = cmp.mapping(function(fallback)
					-- 	if cmp.visible() then
					-- 		if cmp.get_selected_entry() then
					-- 			cmp.confirm({ select = false }) -- Confirm the selected item
					-- 		else
					-- 			cmp.select_next_item() -- Select the first item or cycle forward
					-- 		end
					-- 	else
					-- 		fallback() -- Use default <Tab> behavior
					-- 	end
					-- end, { "i", "s" }),
					['<Tab>'] = cmp.mapping(function(fallback)
						if cmp.visible() then
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							else
								cmp.select_next_item()
							end
							--[[ Replace with your snippet engine (see above sections on this page)
						elseif snippy.can_expand_or_advance() then
							snippy.expand_or_advance() ]]
						elseif has_words_before() then
							cmp.complete()
							if #cmp.get_entries() == 1 then
								cmp.confirm({ select = true })
							end
						else
							fallback()
						end
					end, { "i", "s" }),
					["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept selected item
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" }, -- LSP completions
					{ name = "luasnip" }, -- Snippets
					{ name = "nvim_lsp_signature_help" },
					{ name = "treesitter" },
					{ name = "copilot" },
				}, {
					{ name = "buffer" }, -- Buffer completions
					{ name = "path" },   -- File path completions
				}),
				completion = {
					completeopt = 'menu,menuone,noinsert,select'
				},
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text", -- Show icons with text
						maxwidth = 50,
					}),
				},
			})

			-- Command-line completions
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = "path" },
					{ name = "cmdline" },
				},
			})
		end,
	},
	{
		'mrcjkb/rustaceanvim',
		version = '^6', -- Recommended
		lazy = false, -- This plugin is already lazy
		auto_focus = true,
		-- event = { "BufReadPost", "BufNewFile" }, -- Load on file open
	},
	{
		'saecki/crates.nvim',
		event = { "BufRead Cargo.toml" },
		config = function()
			require('crates').setup()
		end,
	},
	{ 'arkav/lualine-lsp-progress' },
	-- {
	-- 	"ray-x/lsp_signature.nvim",
	-- 	event = "LspAttach", -- Load when an LSP server attaches
	-- 	config = function()
	-- 		require("lsp_signature").setup({
	-- 			bind = true, -- Bind to the LSP
	-- 			floating_window = true, -- Show signature help in a floating window
	-- 			hint_enable = true, -- Enable virtual text hints
	-- 			hint_prefix = "💡 ", -- Customize the prefix for virtual text
	-- 			handler_opts = {
	-- 				border = "rounded", -- Add rounded borders to the floating window
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter"
		}
	},
	{
		"jackMort/ChatGPT.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			require("chatgpt").setup({
				api_key_cmd = "echo $OPENAI_API_KEY",
				openai_params = {
					model = "gpt-4", -- Use GPT-4 if your API supports it
				},
				popup_layout = {
					default = "center",
					size = {
						width = "80%",
						height = "80%",
					},
				},
				popup_window = {
					border = {
						style = "rounded",
					},
					win_options = {
						winblend = 10,
					},
				},
			})
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false }, -- Disable standalone suggestion popup
				panel = { enabled = false },     -- Disable Copilot panel UI
			})
		end,
	},
	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui", -- Optional UI for nvim-dap
			"theHamsta/nvim-dap-virtual-text", -- Optional virtual text for variables
			"nvim-telescope/telescope-dap.nvim",
		},
		config = function()
			-- require("nvim-dap-ui").setup()
			require("nvim-dap-virtual-text").setup()
		end,
	},
	-- {
    -- "SUSTech-data/neopyter",
    -- -- @type neopyter.Option
    -- opts = {
    --     mode="direct",
    --     remote_address = "127.0.0.1:9001",
    --     file_pattern = { "*.ju.*" },
    --     on_attach = function(bufnr)
    --         -- TODO: do some buffer keymap
    --     end,
    --     highlight = {
    --         enable = true,
    --         shortsighted = false,
    --     },
    --     parser = {
    --         -- trim leading/tailing whitespace of cell
    --         trim_whitespace = false,
    --     }
    -- },
-- }
   {
	   "benlubas/molten-nvim",
	   dependencies = {
		   "3rd/image.nvim",
	   },
   },
   {
	   "yetone/avante.nvim",
	   -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	   -- ⚠️ must add this setting! ! !
	   build = "make",
	   event = "VeryLazy",
	   version = false, -- Never set this value to "*"! Never!
	   ---@module 'avante'
	   ---@type avante.Config
	   opts = {
		   -- add any opts here
		   -- for example
		   provider = "openai",
		   providers = {
			   claude = {
				   endpoint = "https://api.anthropic.com",
				   model = "claude-sonnet-4-20250514",
				   timeout = 30000, -- Timeout in milliseconds
				   extra_request_body = {
					   temperature = 0.75,
					   max_tokens = 20480,
				   },
			   },
			   moonshot = {
				   endpoint = "https://api.moonshot.ai/v1",
				   model = "kimi-k2-0711-preview",
				   timeout = 30000, -- Timeout in milliseconds
				   extra_request_body = {
					   temperature = 0.75,
					   max_tokens = 32768,
				   },
			   },
		   },
		   suggestion = {
			   debounce = 600,
			   throttle = 600,
		   },
		   mappings = {
			   ask = "<leader>ua", -- ask
			   edit = "<leader>ue", -- edit
			   refresh = "<leader>ur", -- refresh
		   },
	   },
	   dependencies = {
		   "nvim-lua/plenary.nvim",
		   "MunifTanjim/nui.nvim",
		   --- The below dependencies are optional,
		   "echasnovski/mini.pick", -- for file_selector provider mini.pick
		   "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		   "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		   "ibhagwan/fzf-lua", -- for file_selector provider fzf
		   "stevearc/dressing.nvim", -- for input provider dressing
		   "folke/snacks.nvim", -- for input provider snacks
		   "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		   "zbirenbaum/copilot.lua", -- for providers='copilot'
		   {
			   -- support for image pasting
			   "HakonHarnes/img-clip.nvim",
			   event = "VeryLazy",
			   opts = {
				   -- recommended settings
				   default = {
					   embed_image_as_base64 = false,
					   prompt_for_file_name = false,
					   drag_and_drop = {
						   insert_mode = true,
					   },
					   -- required for Windows users
					   use_absolute_path = true,
				   },
			   },
		   },
		   {
			   -- Make sure to set this up properly if you have lazy=true
			   'MeanderingProgrammer/render-markdown.nvim',
			   opts = {
				   file_types = { "markdown", "Avante" },
			   },
			   ft = { "markdown", "Avante" },
		   },
	   },
   },
   { "duane9/nvim-rg" },
})

