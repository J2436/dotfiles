require("nvim-autopairs")
local Rule = require('nvim-autopairs.rule')

require("nvim-autopairs").setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = true,-- don't check treesitter on java
    }
})
