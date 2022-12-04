local nnoremap = require('jacky.keymap').nnoremap

-- NERDTree
nnoremap("<Leader>nt", "<cmd>NvimTreeToggle<CR>")

require("nvim-tree").setup({
  view = {
    adaptive_size = true,
    preserve_window_proportions = true,
    mappings = {
      list = {
        {}
      }
    },
    number = true,
    relativenumber = true
  },
  renderer = {
    group_empty = false,
    highlight_git = true,
    highlight_opened_files = "name",
    indent_markers = {
      enable = true
    }
  },
  filters = {
    dotfiles = false, -- default is false
    custom = {
      -- "build"
    },
    exclude = {
    }
  }
})

require'nvim-web-devicons'.setup()
