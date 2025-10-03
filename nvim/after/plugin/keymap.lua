local api = vim.api
local g = vim.g
local opt = vim.opt
local keymap = vim.api.nvim_set_keymap
local keymap_set = vim.keymap.set
local default_opts = { noremap = true, silent = true }
local expr_opts = { noremap = true, expr = true, silent = true }

opt.termguicolors = true -- Enable colors in terminal
opt.hlsearch = true --Set highlight on search
opt.number = true --Make line numbers default
opt.relativenumber = true --Make relative number default
opt.mouse = "a" --Enable mouse mode
opt.breakindent = true --Enable break indent
opt.undofile = true --Save undo history
opt.ignorecase = true --Case insensitive searching unless /C or capital in search
opt.smartcase = true -- Smart case
opt.updatetime = 250 --Decrease update time
opt.signcolumn = "yes" -- Always show sign column
opt.clipboard = "unnamedplus" -- Access system clipboard
opt.ts = 4
opt.sw = 4

keymap_set('n', '<leader>ff', require('telescope.builtin').find_files, default_opts)
keymap_set('n', '<leader>fj', require('telescope.builtin').current_buffer_fuzzy_find, default_opts)
keymap_set('n', '<leader>fb', require('telescope.builtin').buffers, default_opts)
keymap_set('n', '<leader>fJ', function()
	require('telescope.builtin').live_grep({
		grep_open_files = true,
	})
end, default_opts)

keymap('n', '<Up>', '<Nop>', default_opts)
keymap('n', '<Down>', '<Nop>', default_opts)
keymap('n', '<Left>', '<Nop>', default_opts)
keymap('n', '<Right>', '<Nop>', default_opts)
keymap('i', '<Up>', '<Nop>', default_opts)
keymap('i', '<Down>', '<Nop>', default_opts)
keymap('i', '<Left>', '<Nop>', default_opts)
keymap('i', '<Right>', '<Nop>', default_opts)
keymap('i', 'jj', '<Esc>', default_opts)
keymap('c', 'jj', '<Esc>', default_opts)
keymap('n', '<leader>ww', ':w<CR>', default_opts)
keymap('n', '<leader>wa', ':wa<CR>', default_opts)
keymap('n', '<leader>wq', ':wq<CR>', default_opts)
keymap('n', '<leader>wv', '<c-w>v', default_opts)
keymap('n', '[b', ':bn<CR>', default_opts)
keymap('n', ']b', ':bp<CR>', default_opts)

-- LSP keys
vim.keymap.set('n', '<leader>jj', '<c-]>', default_opts)
vim.diagnostic.config({
  virtual_text = true,
  virtual_lines = false,
  underline = false,
  update_in_insert = false
})
-- vim.keymap.set("n", "<leader>fr", vim.lsp.buf.references, default_opts)
-- vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, default_opts)

-- vim.opt.completeopt = {'menuone', 'noselect', 'noinsert'}
opt.history = 1000 -- longer command history
opt.undolevels = 1000 -- more undo levels
opt.undofile = true -- persistent undo between sessions
