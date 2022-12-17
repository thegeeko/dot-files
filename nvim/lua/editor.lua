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

	-- reload the config file
	nnoremap({'<F5><F5>', ':source ~/.config/nvim/init.lua<cr>'})
	-- convert snakecase to camelcase
	nnoremap({'<F11><F11>', ':s#_\\(\\l\\)#\\u\\1#g<cr>'})
	-- change the working dir to the current file folder
	nnoremap({'<Space>cd', ':cd %:p:h<cr>:pwd<cr>'})

-- allow split
vim.cmd[[
	set splitbelow
	set splitright
	set nojoinspaces
	set formatoptions+=j
	set nostartofline
]]

-- colorscheme

-- if u want tokyonight just comment gruvbox and uncomment this
-- vim.g.tokyonight_style = "night"
-- vim.g.tokyonight_italic_functions = true
-- vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- vim.cmd[[colorscheme tokyonight]]

-- vim.g.gruvbox_flat_style = "hard"
-- vim.g.gruvbox_italic_functions = true
-- vim.g.gruvbox_sidebars = { "qf", "vista_kind", "terminal", "packer" }
-- vim.g.vim_tex_method = "mupdf"
-- vim.cmd[[ colorscheme gruvbox-flat ]]

local dracula = require("dracula")
dracula.setup({
  -- show the '~' characters after the end of buffers
  show_end_of_buffer = false, -- default false
  -- use transparent background
  transparent_bg = false, -- default false
  -- set custom lualine background color
  lualine_bg_color = nil, -- default nil
  -- set italic comment
  italic_comment = true, -- default false
  -- overrides the default highlights see `:h synIDattr`
  overrides = {
    -- Examples
    -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
      ['@keyword'] = { fg = dracula.colors().pink, italic = true, bold = true },
      ['@type'] = { fg = dracula.colors().bright_cyan, italic = true, bold = true},

    -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
    -- Nothing = {} -- clear highlight of Nothing
  },
})
vim.cmd[[ colorscheme dracula]]

-- trancprancy
-- require("transparent").setup({
--   enable = true, -- boolean: enable transparent
--   extra_groups = { -- table/string: additional groups that should be cleared
--     -- In particular, when you set it to 'all', that means all available groups
--
--     -- example of akinsho/nvim-bufferline.lua
--     "BufferLineTabClose",
--     "BufferlineBufferSelected",
--     "BufferLineFill",
--     "BufferLineBackground",
--     "BufferLineSeparator",
--     "BufferLineIndicatorSelected",
--   },
--   exclude = {}, -- table: groups you don't want to clear
-- })

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
		hook = function()
      require("ts_context_commentstring.internal").update_commentstring()
    end
})

------ auto pairs
require("nvim-autopairs").setup {
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    map = "<M-e>",
    chars = {"<", "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done { map_char = { tex = "" } })

------ indentation and lines nu
vim.opt.list = true
vim.cmd[[ 
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
	show_end_of_line = false,
	char = nil,
	buftype_exclude = {"terminal"},
}

------ some tools config
-- Telescope
require('telescope').load_extension('fzy_native')
nnoremap({'<Space>f', '<cmd>lua require("telescope.builtin").find_files()<cr>'})
nnoremap ({'<Space>g', '<cmd>lua require("telescope.builtin").live_grep()<cr>'})
nnoremap ({'<Space><Space>', '<cmd>lua require("telescope.builtin").buffers()<cr>'})
nnoremap ({'<Space>h', '<cmd>lua require("telescope.builtin").commands()<cr>'})
nnoremap ({'<Space>m', '<cmd>lua require("telescope.builtin").man_pages()<cr>'})
nnoremap ({'<Space>=', '<cmd>lua require("telescope.builtin").git_bcommits()<cr>'})
nnoremap ({'<Space>+', '<cmd>lua require("telescope.builtin").git_commits()<cr>'})

-- cmake
nnoremap({'cg', '<cmd>CMakeGenerate<cr>'})
nnoremap({'cb', '<cmd>CMakeBuild<cr>'})
nnoremap({'cc', '<cmd>CMakeClean<cr>'})

-- float rerm
require'FTerm'.setup({
    border = 'double',
    dimensions  = {
        height = 0.9,
        width = 0.9,
    },
})
nnoremap({'TT' ,'<cmd>lua require("FTerm").toggle()<cr>'})
vim.keymap.set('t', 'TT', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')


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
	update_cwd					= true,
	-- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
	update_focused_file = {
		-- enables the feature
		enable			= false,
		-- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
		-- only relevant when `update_focused_file.enable` is true
		update_cwd	= false,
		-- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
		-- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
		ignore_list = {"node_modules", "zig-out", "zig-cache"}
	},
	-- configuration options for the system open command (`s` in the tree by default)
	system_open = {
		-- the command to run this, leaving nil should work in most cases
		cmd	= nil,
		-- the command arguments as a list
		args = {}
	},

  git = {
    enable = true,
    ignore = false,
    timeout = 500,
  },

	view = {
		-- width of the window, can be either a number (columns) or a string in `%`, for left or right side placement
		width = 30,
		-- height of the window, can be either a number (columns) or a string in `%`, for top or bottom side placement
		height = 30,
		-- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
		side = 'left',
		-- if true the tree will resize itself after opening a file
		auto_resize = true,
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
	" highlight NvimTreeFolderIcon guibg=blue
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
require("nvim-gps").setup()
local gps = require("nvim-gps")

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = 'auto',
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {},
    always_divide_middle = true,
    globalstatus = false,
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch', 'diff', 'diagnostics'},
    lualine_c = {'filename', gps.get_location},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {'location'},
    lualine_y = {},
    lualine_z = {}
  },
  tabline = {},
  extensions = {}
}
