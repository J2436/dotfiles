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


  -- Search
  use {
	'nvim-telescope/telescope.nvim',
	requires = { {'nvim-lua/plenary.nvim'} }

  }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- Picker used with telescope
  use 'preservim/nerdtree'
end)
