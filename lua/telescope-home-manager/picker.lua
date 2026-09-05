local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local actions = require("telescope.actions")
local action_state = require("telescope.actions.state")
local conf = require("telescope.config").values
local previewers = require("telescope.previewers")
local load_options = require("telescope-home-manager.data")
local build_options_json = require("telescope-home-manager.nix")

local cached_path = nil

local function add_field(lines, label, value)
  table.insert(lines, label .. ":")
  if value then
    for _, line in ipairs(vim.split(value, "\n")) do
      table.insert(lines, line)
    end
  else
    table.insert(lines, "none")
  end
  table.insert(lines, "")
end

local function home_manager_picker(opts)
  opts = opts or {}

  if not cached_path then
    cached_path = build_options_json()
  end

  local homemanager = load_options(cached_path)

  pickers.new(opts, {
    prompt_title = "Home Manager Options",
    finder = finders.new_table({
      results = homemanager,

      entry_maker = function(entry)
        return {
          value = entry,
          display = entry.name,
          ordinal = entry.name,
        }
      end,
    }),
    sorter = conf.generic_sorter(opts),
    attach_mappings = function(prompt_bufnr, map)
      actions.select_default:replace(function()
        local entry = action_state.get_selected_entry()
        actions.close(prompt_bufnr)
        print(entry.value.name, entry.value.type, entry.value.description)
      end)
      return true
    end,
    previewer = previewers.new_buffer_previewer({
      define_preview = function(self, entry, status)
        local lines = {
          "Name: " .. entry.value.name,
          "Type: " .. (entry.value.type or "unknown"),
          "",
        }

        add_field(lines, "Description", entry.value.description)
        add_field(lines, "Default", entry.value.default)
        add_field(lines, "Example", entry.value.example)

        vim.api.nvim_buf_set_lines(self.state.bufnr, 0, -1, false, lines)
      end,
    }),
  }):find()
end

return home_manager_picker

