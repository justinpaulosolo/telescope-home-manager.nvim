return require("telescope").register_extension({
  setup = function(ext_config, config)
    -- nothing to configure yet
  end,
  exports = {
    home_manager = require("telescope-home-manager.picker"),
  },
})
