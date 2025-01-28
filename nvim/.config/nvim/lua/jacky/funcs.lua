function exec_file()
  local file_name = arg[0]
  print(file_name)
end

function isVSCode()
  return vim.g.vscode
end

function is_index_within_classname_quotes(input_string, index)
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
