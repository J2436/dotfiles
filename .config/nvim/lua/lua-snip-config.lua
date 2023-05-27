local ls = require'luasnip'
local fmt = require('luasnip.extras.fmt')

local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node

ls.setup({
  snip_env = {
      s = function(...)
        local snip = ls.s(...)
        -- we can't just access the global `ls_file_snippets`, since it will be
        -- resolved in the environment of the scope in which it was defined.
        table.insert(getfenv(2).ls_file_snippets, snip)
      end,
      parse = function(...)
        local snip = ls.parser.parse_snippet(...)
        table.insert(getfenv(2).ls_file_snippets, snip)
      end,
      ...
    },
})
require("luasnip.loaders.from_lua").load({paths = "~/snippets"})

-- vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
-- vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
vim.api.nvim_set_keymap("i", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.api.nvim_set_keymap("s", "<C-E>", "<Plug>luasnip-next-choice", {})
vim.keymap.set("n", "<leader><leader>s", "<cmd>source ~/.config/nvim/lua/lua-snip-config.lua<CR>")
