return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Colorschemes
  use({
	"catppuccin/nvim",
	as = "catppuccin"
  })
  use 'ellisonleao/gruvbox.nvim'

  -- Dev
  use 'neovim/nvim-lspconfig' -- Collection of configurations for the built-in LSP client
  use 'williamboman/nvim-lsp-installer'

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }
  use 'hrsh7th/nvim-cmp' -- Autocompletion
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'

  -- Search
  use {
	'nvim-telescope/telescope.nvim',
	requires = { {'nvim-lua/plenary.nvim'} }

  }
  
  -- Git
  use 'tpope/vim-fugitive'
  use 'airblade/vim-gitgutter'

  -- File search
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- Picker used with telescope
  use 'preservim/nerdtree'

  -- Formatting
  use 'sbdchd/neoformat'
end)
