vim.g.mapleader=','

-- Mapping waiting time
vim.o.timeout=false
vim.o.ttimeout=true
vim.o.ttimeoutlen=100

-- Display
vim.o.scrolloff=3
vim.o.laststatus=2
vim.o.wrap=false

-- Sidebar
vim.o.number=true
vim.o.relativenumber=true
vim.showcmd=true

-- Search
vim.o.incsearch=true 
vim.o.ignorecase=true
vim.o.smartcase=true

-- Whitespace
vim.o.autoindent=true
vim.o.smartindent=true
vim.o.tabstop=2
vim.o.shiftwidth=2
vim.o.expandtab=true
vim.o.hlsearch=false

-- Remove auto comment
vim.api.nvim_command('set formatoptions-=cro')

-- Git Gutter
vim.o.updatetime=100