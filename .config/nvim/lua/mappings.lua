local nnoremap = require('jacky.keymap').nnoremap

-- Telescope
nnoremap("<Leader>ff", "<cmd>Telescope find_files<CR>")
nnoremap("<Leader>fg", "<cmd>Telescope file_grep<CR>")
nnoremap("<Leader>fb", "<cmd>Telescope buffers<CR>")
nnoremap("<Leader>fh", "<cmd>Telescope help_tags<CR>")

-- NERDTree
nnoremap("<Leader>nt", "<cmd>NERDTree<CR>")
