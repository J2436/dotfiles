local api = require('Comment.api')
local config = require('Comment.config'):get()

-- Toggle current line (linewise) using C-/
vim.keymap.set('n', '<C-_>', api.toggle.linewise.current)

-- Toggle current line (blockwise) using C-\
vim.keymap.set('n', '<C-\\>', api.toggle.blockwise.current)

-- Toggle lines (linewise) with dot-repeat support
-- Example: <leader>gc3j will comment 4 lines
vim.keymap.set(
    'n', '<leader>gc', api.call('toggle.linewise', 'g@'),
    { expr = true }
)

