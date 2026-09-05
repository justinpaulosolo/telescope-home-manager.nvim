local function load_options(path)
  local content = vim.fn.readfile(path)
  local content_str = table.concat(content, "\n")
  local data = vim.json.decode(content_str)

  local results = {}
  for option_name, option_data in pairs(data) do
    local default_text = nil
    if option_data.default then
      default_text = option_data.default.text
    end

    local example_text = nil
    if option_data.example then
      example_text = option_data.example.text
    end

    table.insert(results, {
      name = option_name,
      type = option_data.type,
      description = option_data.description,
      default = default_text,
      example = example_text,
    })
  end

  return results
end

return load_options
