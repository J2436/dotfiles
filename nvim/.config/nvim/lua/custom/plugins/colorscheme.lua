return {
  -- {
  --   'navarasu/onedark.nvim',
  --   priority = 1000,
  --   config = function()
  --     require('onedark').setup {
  --       style = 'dark',
  --       transparent = 'false',
  --       lualine = {
  --         transparent = 'false'
  --       }
  --     }
  --   end,
  -- },
  {
    'sainnhe/gruvbox-material',
    config = function()
      vim.g.gruvbox_material_background = 'hard'
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_better_performance = 1

      -- vim.cmd.colorscheme 'gruvbox-material'
      vim.api.nvim_set_hl(0, 'FloatBorder', { link = 'Normal' })
    end
  },
  {
    "arturgoms/moonbow.nvim",
    config = function()
      vim.cmd.colorscheme 'moonbow'
    end
  }
}
