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
  { "ellisonleao/gruvbox.nvim", priority = 1000 , config = true },
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_cursor = 'orange'
      vim.cmd.colorscheme 'gruvbox-material'
      vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })
    end
  },
  {
    'rebelot/kanagawa.nvim',
    config = function()
    end
  }
}
