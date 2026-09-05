# telescope-home-manager.nvim

> **Note:** This was built as a personal learning project. It works, but
> there are bugs, it's not optimized, and it's probably not built the "proper"
> way a production plugin would be. Dont be cringe

Browse [Home Manager](https://github.com/nix-community/home-manager) options
(names, types, defaults, descriptions) from a Telescope picker — no more
googling "can home-manager manage X".

## Requirements

- [Neovim](https://neovim.io/) 0.10+
- [Telescope.nvim](https://github.com/nvim-telescope/telescope.nvim) and its
  dependency [plenary.nvim](https://github.com/nvim-lua/plenary.nvim)
- [Nix](https://nixos.org/) installed and on `$PATH`, with flakes enabled
  (this plugin runs `nix build` under the hood to fetch the latest options)

## Installation

### lazy.nvim

```lua
{
  "justinpaulosolo/telescope-home-manager.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-telescope/telescope.nvim",
  },
  config = function()
    require("telescope").load_extension("home_manager")
  end,
}
```

## Usage

```
:Telescope home_manager
```

Fuzzy-search across every Home Manager option. The preview pane shows the
option's type, description, default value, and example.

**Note:** the first time you open the picker (per Neovim session), it runs
`nix build` to fetch the current options data, which can take a few seconds.
Subsequent opens in the same session are instant.

## How it works

This plugin runs `nix build github:nix-community/home-manager#docs-json`,
which builds the same `options.json` that powers Home Manager's official
online docs. That JSON is parsed and fed into a standard Telescope picker.

## License

MIT
