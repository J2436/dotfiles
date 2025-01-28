-- [Configure nvim-cmp]
-- See `:help cmp`

local has_words_before = function()
  unpack = unpack or table.unpack
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local function is_index_within_classname_quotes(input_string, index)
  -- Match the className="..." pattern and capture the content inside the quotes
  local start_pos, end_pos = input_string:find('className%s*=%s*"([^"]*)"')

  if not start_pos then
    return false, "className attribute not found"
  end

  -- Find the positions of the quotes
  local opening_quote_pos = input_string:find('"', start_pos)
  local closing_quote_pos = input_string:find('"', opening_quote_pos + 1)

  -- Check if the index is within the quotes
  if index > opening_quote_pos and index < closing_quote_pos then
    return true, "Index is within the quotes of className"
  else
    return false, "Index is outside the quotes of className"
  end
end

local cmp = require 'cmp'
local luasnip = require 'luasnip'
require('luasnip.loaders.from_vscode').lazy_load()
luasnip.config.setup {}

-- Set hover borders to be like cmp
vim.cmd(':set winhighlight=' .. cmp.config.window.bordered().winhighlight)
-- If you want insert `(` after select function or method item
local cmp_autopairs = require("nvim-autopairs.completion.cmp")
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },

  window = {
    completion = cmp.config.window.bordered({
      -- Change the border background color
      winhighlight = "Normal:Normal,FloatBorder:BorderBG,CursorLine:PmenuSel,Search:None",
    }),
    documentation = cmp.config.window.bordered(),
  },

  mapping = cmp.mapping.preset.insert {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete {},
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ["<Tab>"] = cmp.mapping(function(fallback)
      local row, col = unpack(vim.api.nvim_win_get_cursor(0))
      if cmp.visible() then
        local entry = cmp.get_selected_entry()
        if not entry then
          cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
          cmp.confirm()
        end
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  },
  formatting = {
    -- kind icon / color icon + completion + kind text
    fields = { "menu", "abbr", "kind" },

    format = function(entry, item)
      local entryItem = entry:get_completion_item()
      local color = entryItem.documentation

      -- check if color is hexcolor
      if color and type(color) == "string" and color:match "^#%x%x%x%x%x%x$" then
        local hl = "hex-" .. color:sub(2)

        if #vim.api.nvim_get_hl(0, { name = hl }) == 0 then
          vim.api.nvim_set_hl(0, hl, { fg = color })
        end

        item.menu = " "
        item.menu_hl_group = hl

        -- else
        -- add your lspkind icon here!
        -- item.menu_hl_group = item.kind_hl_group
      end

      return item
    end,
  },
  performance = {
    max_view_entries = 11,
  },
  sources = {
    { name = 'nvim_lsp',
      entry_filter = function(entry, ctx)
        if ctx.filetype == 'typescriptreact' then
          local startindex, endindex = string.find(ctx.cursor_line, 'className="')
          if is_index_within_classname_quotes(ctx.cursor_line, ctx.cursor.col) ~= nil then
            return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Module'
          end
          local kind = require('cmp.types').lsp.CompletionItemKind[entry:get_kind()];
          local kinds_to_hide = { 'Text', 'Module' }
          if kinds_to_hide[kind] then
            return false;
          else
            return true;
          end
        end
        return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
      end
    },
    { name = 'luasnip' },
    { name = 'path' },
    per_filetype = {
      codecompanion = { "codecompanion" },
    }
  },
}

-- Setup dadbod
cmp.setup.filetype({ "sql" }, {
  sources = {
    { name = "vim-dadbod-completion" },
    { name = "buffer" }
  },
})
