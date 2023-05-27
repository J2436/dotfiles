local formatGrp = vim.api.nvim_create_augroup("NewlineComment", { clear = true })

vim.api.nvim_create_autocmd("BufEnter", {
  command = "set formatoptions-=cro",
  group = formatGrp
});
