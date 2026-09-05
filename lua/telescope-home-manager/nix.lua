local function build_options_json()
  local result = vim.system(
    { "nix", "build", "github:nix-community/home-manager#docs-json", "--no-link", "--print-out-paths" },
    { text = true }
  ):wait()

  if result.code ~= 0 then
    error("nix build failed: " .. result.stderr)
  end

  local store_dir = vim.trim(result.stdout)
  local options_path = store_dir .. "/share/doc/home-manager/options.json"

  return options_path
end

return build_options_json
