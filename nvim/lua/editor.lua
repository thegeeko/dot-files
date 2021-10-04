------ basic config
-- copy and paste to system
vim.cmd [[
	vnoremap <C-y> "+y
	nnoremap <C-Y> "+yg_
	nnoremap <C-y> "+y
	nnoremap <C-yy> "+yy
	
	nnoremap <C-p> "+p
	nnoremap <C-P> "+P
	vnoremap <C-p> "+p
	vnoremap <C-P> "+P
]]
-- allow split
vim.cmd[[
	set splitbelow
	set splitright
	set nojoinspaces
	set formatoptions+=j
	set nostartofline
]]
-- colorscheme
vim.g.gruvbox_italic_functions = true
vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }
vim.g.gruvbox_flat_style = "hard"

vim.cmd[[ colorscheme gruvbox-flat ]]

------ comments
require('nvim_comment').setup(
	{
		-- Linters prefer comment and line to have a space in between markers
		marker_padding = true,
		-- should comment out empty or whitespace only lines
		comment_empty = true,
		-- Should key mappings be created
		create_mappings = true,
		-- Normal mode mapping left hand side
		line_mapping = "\\\\",
		-- Visual/Operator mapping left hand side
		operator_mapping = "\\",
		-- Hook function to call before commenting takes place
		hook = nil
	}
)

------ indentation and lines nu
vim.opt.list = true
vim.cmd[[ 
	set listchars=tab:‣\ ,trail:·,precedes:«,extends:»,eol:¬,space:., 
	set softtabstop=2
	set tabstop=2
	set shiftwidth=2
	set smarttab
	set autoindent
	set smartindent
	set nu rnu
	]]

require("indent_blankline").setup {
	show_end_of_line = true,
	char = ".",
	buftype_exclude = {"terminal"},

}

------ some tools config
-- Telescope
require('telescope').load_extension('fzy_native')
vim.cmd[[
	nnoremap <Space>f <cmd>lua require('telescope.builtin').find_files()<cr>
	nnoremap <Space>g <cmd>lua require('telescope.builtin').live_grep()<cr>
	nnoremap <Space><Space> <cmd>lua require('telescope.builtin').buffers()<cr>
	nnoremap <Space>h <cmd>lua require('telescope.builtin').commands()<cr>
	nnoremap <Space>h <cmd>lua require('telescope.builtin').help_tags()<cr>
	nnoremap <Space>m <cmd>lua require('telescope.builtin').man_pages()<cr>
	nnoremap <Space>= <cmd>lua require('telescope.builtin').git_bcommits()<cr>
	nnoremap <Space>+ <cmd>lua require('telescope.builtin').git_commits()<cr>
]]
-- cmake
vim.cmd[[
	nnoremap cg <cmd>CMakeGenerate<cr>
	nnoremap cb <cmd>CMakeBuild<cr>
	nnoremap cc <cmd>CMakeClean<cr>
]]
------ git signs

require('gitsigns').setup {
	signs = {
		add = {hl = 'GitSignsAdd'	 , text = '│', numhl='GitSignsAddNr' , linehl='GitSignsAddLn'},
		change = {hl = 'GitSignsChange', text = '│', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
		delete = {hl = 'GitSignsDelete', text = '_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
		topdelete = {hl = 'GitSignsDelete', text = '‾', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
		changedelete = {hl = 'GitSignsChange', text = '~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
	},
	signcolumn = true,	-- Toggle with `:Gitsigns toggle_signs`
	numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
	word_diff	= false, -- Toggle with `:Gitsigns toggle_word_diff`
	keymaps = {
		-- Default keymap options
		noremap = true,

		-- ['n ]c'] = { expr = true, "&diff ? ']c' : '<cmd>lua require\"gitsigns.actions\".next_hunk()<CR>'"},
		-- ['n [c'] = { expr = true, "&diff ? '[c' : '<cmd>lua require\"gitsigns.actions\".prev_hunk()<CR>'"},

		-- ['n <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
		-- ['v <leader>hs'] = '<cmd>lua require"gitsigns".stage_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		-- ['n <leader>hu'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
		-- ['n <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
		-- ['v <leader>hr'] = '<cmd>lua require"gitsigns".reset_hunk({vim.fn.line("."), vim.fn.line("v")})<CR>',
		-- ['n <leader>hR'] = '<cmd>lua require"gitsigns".reset_buffer()<CR>',
		-- ['n <leader>hp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',
		-- ['n <leader>hb'] = '<cmd>lua require"gitsigns".blame_line(true)<CR>',
		-- ['n <leader>hS'] = '<cmd>lua require"gitsigns".stage_buffer()<CR>',
		-- ['n <leader>hU'] = '<cmd>lua require"gitsigns".reset_buffer_index()<CR>',

		-- Text objects
		-- ['o ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>',
		-- ['x ih'] = ':<C-U>lua require"gitsigns.actions".select_hunk()<CR>'
	},
	watch_gitdir = {
		interval = 1000,
		follow_files = true
	},
	attach_to_untracked = true,
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
	},
	current_line_blame_formatter_opts = {
		relative_time = false
	},
	sign_priority = 6,
	update_debounce = 100,
	status_formatter = nil, -- Use default
	max_file_length = 40000,
	preview_config = {
		-- Options passed to nvim_open_win
		border = 'single',
		style = 'minimal',
		relative = 'cursor',
		row = 0,
		col = 1
	},
	yadm = {
		enable = false
	},
}


------ bar
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'gruvbox-flat',
		component_separators = {'/', '/'},
		section_separators = {' ', ' '},
		disabled_filetypes = {}
	}
}
