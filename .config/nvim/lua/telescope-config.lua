local nnoremap = require('jacky.keymap').nnoremap

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  },
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "dist",
      "build/"
    },
    layout_strategy = 'vertical',
    layout_config = {
      vertical = { width = 0.9, preview_height = 0.7 }
    }
  }
}

-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- Telescope Mappings
nnoremap("<Leader>ff", "<cmd>Telescope find_files<CR>")
nnoremap("<Leader>fg", "<cmd>Telescope live_grep<CR>")
nnoremap("<Leader>fb", "<cmd>Telescope buffers<CR>")
nnoremap("<Leader>fh", "<cmd>Telescope help_tags<CR>")
