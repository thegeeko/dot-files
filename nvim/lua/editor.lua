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

	nnoremap <F5><F5> :source ~/.config/nvim/init.lua<cr>
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

	noremap <F12><F12> :%s/  /	/g<cr>
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

------ vnim tree
require('nvim-tree').setup {
	-- disables netrw completely
	disable_netrw			 = true,
	-- hijack netrw window on startup
	hijack_netrw				= true,
	-- open the tree when running this setup function
	open_on_setup			 = false,
	-- will not open on setup if the filetype is in this list
	ignore_ft_on_setup	= {},
	-- closes neovim automatically when the tree is the last **WINDOW** in the view
	auto_close					= false,
	-- opens the tree when changing/opening a new tab if the tree wasn't previously opened
	open_on_tab				 = false,
	-- hijacks new directory buffers when they are opened.
	update_to_buf_dir	 = {
		-- enable the feature
		enable = true,
		-- allow to open the tree if it was previously closed
		auto_open = true,
	},
	-- hijack the cursor in the tree to put it at the start of the filename
	hijack_cursor			 = false,
	-- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
	update_cwd					= false,
	-- show lsp diagnostics in the signcolumn
	lsp_diagnostics		 = false,
	-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	update_focused_file = {
		-- enables the feature
		enable			= false,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_cwd	= false,
		-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
		-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
		ignore_list = {}
	},
	-- configuration options for the system open command (`s` in the tree by default)
	system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd	= nil,
		-- the command arguments as a list
		args = {}
	},

	view = {
		-- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
		width = 30,
		-- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
		height = 30,
		-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		side = 'left',
		-- if true the tree will resize itself after opening a file
		auto_resize = false,
		mappings = {
			-- custom only false will merge the list with the default mappings
			-- if true, it will only use your list to set the mappings
			custom_only = false,
			-- list of mappings to set on the tree manually
			list = {}
		}
	}
}

vim.cmd [[
	let g:nvim_tree_highlight_opened_files = 1
	let g:nvim_tree_indent_markers = 1
	let g:nvim_tree_special_files = { 'README.md': 1, 'Makefile': 1, 'MAKEFILE': 1 }
	nnoremap tt :NvimTreeToggle<CR>
	nnoremap tr :NvimTreeRefresh<CR>
	set termguicolors	
	highlight NvimTreeFolderIcon guibg=blue
]]

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
