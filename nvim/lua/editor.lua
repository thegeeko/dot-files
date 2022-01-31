------ basic config
-- copy and paste to system
	vnoremap({'<C-y>', '"+y'})
	nnoremap({'<C-Y>', '"+yg_'})
	nnoremap({'<C-y>', '"+y'})
	nnoremap({'<C-yy>', '"+yy'})
	nnoremap({'<C-p>', '"+p'})
	nnoremap({'<C-P>', '"+P'})
	vnoremap({'<C-p>', '"+p'})
	vnoremap({'<C-P>', '"+P'})

	nnoremap({'<F5><F5>', ':source ~/.config/nvim/init.lua<cr>'})
	nnoremap({'<F11><F11>', ':s#_\\(\\l\\)#\\u\\1#g<cr>'})

-- allow split
vim.cmd[[
	set splitbelow
	set splitright
	set nojoinspaces
	set formatoptions+=j
	set nostartofline
]]
-- colorscheme
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- vim.cmd[[colorscheme gruvbox-flat]]

vim.g.gruvbox_flat_style = "hard"
vim.g.gruvbox_italic_functions = true
vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }

vim.cmd[[ colorscheme gruvbox-flat ]]

------ splash screen
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
		"																										 ",
		"	███╗	 ██╗███████╗ ██████╗ ██╗	 ██╗██╗███╗	 ███╗ ",
		"	████╗	██║██╔════╝██╔═══██╗██║	 ██║██║████╗ ████║ ",
		"	██╔██╗ ██║█████╗	██║	 ██║██║	 ██║██║██╔████╔██║ ",
		"	██║╚██╗██║██╔══╝	██║	 ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
		"	██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
		"	╚═╝	╚═══╝╚══════╝ ╚═════╝	 ╚═══╝	╚═╝╚═╝		 ╚═╝ ",
		"																										 ",
}

-- Set menu
dashboard.section.buttons.val = {
		dashboard.button( "e", "	> New file" , ":ene <BAR> startinsert <CR>"),
		dashboard.button( "f", "	> Find file", ":cd $HOME/projects | Telescope find_files<CR>"),
		dashboard.button( "r", "	> Recent"	 , ":Telescope oldfiles<CR>"),
		dashboard.button( "s", "	> Congig" , ":e $HOME/.config/nvim/init.lua"),
		dashboard.button( "q", "	> Quit NVIM", ":qa<CR>"),
}

-- Set footer
local fortune = require("alpha.fortune")
dashboard.section.footer.val = fortune()

-- Send config to alpha
alpha.setup(dashboard.opts)

-- Disable folding on alpha buffer
vim.cmd([[
		autocmd FileType alpha setlocal nofoldenable
]])

------ comments
require('nvim_comment').setup({
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
})

------ indentation and lines nu
vim.opt.list = true
vim.cmd[[ 
	set listchars=tab:-\ ,trail:·,precedes:«,extends:»,eol:¬,space:., 
	set softtabstop=2
	set tabstop=2
	set shiftwidth=2
	set smarttab
	set autoindent
	set smartindent
	set nu rnu

]]

	nnoremap({'<F12><F12>', ' :%s/	/	/g<cr>'})

require("indent_blankline").setup {
	show_end_of_line = true,
	char = ".",
	buftype_exclude = {"terminal"},
}

------ some tools config
-- Telescope
require('telescope').load_extension('fzy_native')
nnoremap({'<Space>f', '<cmd>lua require("telescope.builtin").find_files()<cr>'})
nnoremap ({'<Space>g', '<cmd>lua require("telescope.builtin").live_grep()<cr>'})
nnoremap ({'<Space><Space>', '<cmd>lua require("telescope.builtin").buffers()<cr>'})
nnoremap ({'<Space>h <cmd>lua', 'require("telescope.builtin").commands()<cr>'})
nnoremap ({'<Space>h <cmd>lua', 'require("telescope.builtin").help_tags()<cr>'})
nnoremap ({'<Space>m <cmd>lua', 'require("telescope.builtin").man_pages()<cr>'})
nnoremap ({'<Space>= <cmd>lua', 'require("telescope.builtin").git_bcommits()<cr>'})
nnoremap ({'<Space>+ <cmd>lua', 'require("telescope.builtin").git_commits()<cr>'})
-- cmake
nnoremap({'cg', '<cmd>CMakeGenerate<cr>'})
nnoremap({'cb', '<cmd>CMakeBuild<cr>'})
nnoremap({'cc', '<cmd>CMakeClean<cr>'})

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

vim.g.nvim_tree_highlight_opened_files = 1
vim.g.nvim_tree_indent_markers = 1
vim.g.nvim_tree_special_files = { 'README.md', 'Makefile', 'MAKEFILE' }

nnoremap({'tt', ':NvimTreeToggle<CR>'})
nnoremap({'tr', ':NvimTreeRefresh<CR>'})

vim.cmd [[
	set termguicolors	
	highlight NvimTreeFolderIcon guibg=blue
]]

---- discord
require("presence"):setup({
	-- General options
	auto_update				 = true,											 -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
	neovim_image_text	 = "The One True Text Editor", -- Text displayed when hovered over the Neovim image
	main_image					= "file",									 -- Main image display (either "neovim" or "file")
	client_id					 = "793271441293967371",			 -- Use your own Discord application client id (not recommended)
	log_level					 = nil,												-- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
	debounce_timeout		= 10,												 -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
	enable_line_number	= false,											-- Displays the current line number instead of the current project
	blacklist					 = {},												 -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
	buttons						 = true,											 -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)

	-- Rich Presence text options
	editing_text				= "Editing %s",							 -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
	file_explorer_text	= "Browsing %s",							-- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
	git_commit_text		 = "Committing changes",			 -- Format string rendered when committing changes in git (either string or function(filename: string): string)
	plugin_manager_text = "Managing plugins",				 -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
	reading_text				= "Reading %s",							 -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
	workspace_text			= "Working on %s",						-- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
	line_number_text		= "Line %s out of %s",				-- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

------ bar
require('lualine').setup {
	options = {
		icons_enabled = true,
		theme = 'tokyonight',
		component_separators = {'/', '/'},
		section_separators = {' ', ' '},
		disabled_filetypes = {}
	}
}
