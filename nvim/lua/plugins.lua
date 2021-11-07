-- install packer if it's not
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
	fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
	vim.cmd 'packadd packer.nvim'
end

return require('packer').startup({function()
	-- themes
	use 'eddyekofo94/gruvbox-flat.nvim'
	use 'kyazdani42/nvim-web-devicons'
	use 'hoob3rt/lualine.nvim'

	-- language support
	use 'cdelledonne/vim-cmake'
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
	use{
		'glepnir/lspsaga.nvim',
		requires = {'neovim/nvim-lspconfig'}
	}
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate'
	}

	-- editor tools
	use 'lukas-reineke/indent-blankline.nvim'
	use 'terrortylor/nvim-comment'
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
	use {
		'goolord/alpha-nvim',
		requires = {'kyazdani42/nvim-web-devicons'},
	}
end,
config = {
	display = {
		open_fn = require('packer.util').float,
	}
}})
