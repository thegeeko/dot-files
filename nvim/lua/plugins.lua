-- install packer if it's not
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd 'packadd packer.nvim'
end

return require('packer').startup({function()
	-- themes
	use 'folke/tokyonight.nvim'
	use 'eddyekofo94/gruvbox-flat.nvim'
  use 'Mofiqul/dracula.nvim'
	use 'kyazdani42/nvim-web-devicons'
	use 'hoob3rt/lualine.nvim'
	use 'xiyaowong/nvim-transparent'

	-- language support
  use 'github/copilot.vim'
	use 'cdelledonne/vim-cmake'
  use 'jose-elias-alvarez/null-ls.nvim'
	use {
		'SmiteshP/nvim-gps',
		requires = 'nvim-treesitter/nvim-treesitter'
	}
	use	'lervag/vimtex' 
	use {
	  'ray-x/lsp_signature.nvim',
	}
	use{
		'hrsh7th/nvim-cmp',
		requires={
			 'hrsh7th/cmp-nvim-lsp',
			 'hrsh7th/cmp-buffer',
			 'hrsh7th/cmp-path',
			 'hrsh7th/cmp-nvim-lua',
			 'ray-x/cmp-treesitter',
			 'f3fora/cmp-spell',
			 'L3MON4D3/LuaSnip',
			 'saadparwaiz1/cmp_luasnip',
			 'neovim/nvim-lspconfig',
		}
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- editor tools
	use 'numToStr/FTerm.nvim'
	use 'lukas-reineke/indent-blankline.nvim'
	use 'andweeb/presence.nvim'
	use 'terrortylor/nvim-comment'
  use 'JoosepAlviste/nvim-ts-context-commentstring'
  use 'windwp/nvim-autopairs'
	use {
		'lewis6991/gitsigns.nvim',
		requires = {'nvim-lua/plenary.nvim'}
	}
	use {
		'nvim-telescope/telescope.nvim',
		requires = {
			'nvim-lua/plenary.nvim',
			'nvim-telescope/telescope-fzy-native.nvim'
		}
	}
	use {
		'kyazdani42/nvim-tree.lua',
		requires = {'kyazdani42/nvim-web-devicons'},
	}
end,

config = {
	display = {
		open_fn = require('packer.util').float,
	}
}})
