function exec_file()
  local file_name = arg[0]
  print(file_name)
end

function isVSCode()
  return vim.g.vscode
end
