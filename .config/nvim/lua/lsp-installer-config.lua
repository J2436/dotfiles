local lsp_installer = require("nvim-lsp-installer").setup{}
local lspconfig = require("lspconfig")
local on_attach = require("jacky.lsp-attach")

lspconfig.tsserver.setup {
  on_attach = on_attach
}

lspconfig.lemminx.setup {
  on_attach = on_attach
}
