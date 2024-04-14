return {
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'dark',
        transparent = 'false',
        lualine = {
          transparent = 'false'
        }
      }
    end,
  },
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_cursor = 'orange'
      vim.g.gruvbox_material_transparent_background = 1
      vim.cmd.colorscheme 'gruvbox-material'
    end
  },
  {
    'rebelot/kanagawa.nvim',
    config = function()
    end
  }
}
