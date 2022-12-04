return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Colorschemes
  use({
    "catppuccin/nvim",
    as = "catppuccin"
  })
  use 'ellisonleao/gruvbox.nvim'
  use 'folke/tokyonight.nvim'
  use "EdenEast/nightfox.nvim"

  -- LSP
  use {
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "neovim/nvim-lspconfig",
  }

  use {
      'nvim-treesitter/nvim-treesitter',
      run = ':TSUpdate'
    }

  -- Autocompletion
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'L3MON4D3/LuaSnip'
  use "windwp/nvim-autopairs"

  -- Search
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }

  use {
    'nvim-tree/nvim-tree.lua',
    requires = {
      'nvim-tree/nvim-web-devicons', -- optional, for file icons
    },
    tag = 'nightly' -- optional, updated every week. (see issue #1193)
  }

  -- Git
  use 'tpope/vim-fugitive'
  use 'lewis6991/gitsigns.nvim'

  -- File search
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' } -- Picker used with telescope

  -- Diagnostics
  use 'https://git.sr.ht/~whynothugo/lsp_lines.nvim'
  use "lukas-reineke/indent-blankline.nvim"

  -- Formatting
  use 'sbdchd/neoformat'

  -- Java
  use 'mfussenegger/nvim-jdtls'
  use 'mfussenegger/nvim-dap'

  -- Surround
  use({
    "kylechui/nvim-surround",
    tag = "*", -- Use for stability; omit to use `main` branch for the latest features
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
})

end)
