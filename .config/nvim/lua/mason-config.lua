local on_attach = require("jacky.lsp-attach")
local lspconfig = require("lspconfig")

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers({
  function(server_name) -- default handler (optional)
    require("lspconfig")[server_name].setup({
      on_attach = on_attach
    })
  end,
  ["sumneko_lua"] = function()
    lspconfig.sumneko_lua.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim", "use" },
          },
        },
      },
    })
  end,
  ["tsserver"] = function()
    lspconfig.tsserver.setup({
      settings = {},
    })
  end,
})

-- Note Setting LSP lines here as it needs to be done after LSP (doublecheck)
vim.diagnostic.config({
  virtual_text = false,
  update_in_insert = true,
  signs = {
    severity = "ERROR",
  },
  virtual_lines = { only_current_line = true }
})

require("lsp_lines").setup({})
