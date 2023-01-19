-- install packer if it's not
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  vim.cmd 'packadd packer.nvim'
end

return require('packer').startup({ function()
  -- themes
  use 'folke/tokyonight.nvim'
  use 'eddyekofo94/gruvbox-flat.nvim'
  use 'morhetz/gruvbox'
  use 'Mofiqul/dracula.nvim'
  use 'tanvirtin/monokai.nvim'
  use 'kyazdani42/nvim-web-devicons'
  use 'hoob3rt/lualine.nvim'
  use 'xiyaowong/nvim-transparent'

  -- language support
  use 'github/copilot.vim'
  use 'cdelledonne/vim-cmake'
  use {
    'saecki/crates.nvim',
    tag = 'v0.3.0',
    requires = { 'nvim-lua/plenary.nvim' },
    config = function()
      require('crates').setup({
        null_ls = {
          enabled = true,
          name = "crates.nvim",
        },
      })
    end,
  }
  use {
    'SmiteshP/nvim-gps',
    requires = 'nvim-treesitter/nvim-treesitter'
  }
  use 'lervag/vimtex'
  use {
    'ray-x/lsp_signature.nvim',
  }
  use {
    'VonHeikemen/lsp-zero.nvim',
    requires = {
      -- LSP Support
      { 'neovim/nvim-lspconfig' },
      { 'williamboman/mason.nvim' },
      { 'williamboman/mason-lspconfig.nvim' },

      -- Autocompletion
      { 'hrsh7th/nvim-cmp' },
      { 'hrsh7th/cmp-buffer' },
      { 'hrsh7th/cmp-path' },
      { 'saadparwaiz1/cmp_luasnip' },
      { 'hrsh7th/cmp-nvim-lsp' },
      { 'hrsh7th/cmp-nvim-lua' },

      -- Snippets
      { 'L3MON4D3/LuaSnip' },
      -- Snippet Collection (Optional)
      { 'rafamadriz/friendly-snippets' },
    }
  }
  use { "jayp0521/mason-null-ls.nvim",
    requires = { "jose-elias-alvarez/null-ls.nvim" } }
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
    requires = { 'nvim-lua/plenary.nvim' }
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
    requires = { 'kyazdani42/nvim-web-devicons' },
  }
end,

  config = {
    display = {
      open_fn = require('packer.util').float,
    }
  } })
