{ lib, ... }:
{
  # Picker for LSP definitions: selecting an entry jumps there and closes the picker.
  plugins.telescope.enable = true;

  extraFiles."lua/config/symbol-picker.lua".source = ./lua/config/symbol-picker.lua;

  keymaps = [
    {
      mode = "n";
      key = "gd";
      action = lib.nixvim.mkRaw /* lua */ ''function() require("telescope.builtin").lsp_definitions() end'';
      options.desc = "Go to definition (picker)";
    }
    {
      mode = "n";
      key = "<leader>s";
      action = lib.nixvim.mkRaw /* lua */ ''function() require("config.symbol-picker").workspace() end'';
      options.desc = "Workspace symbols (LSP)";
    }
    {
      mode = "n";
      key = "<leader>sd";
      action = lib.nixvim.mkRaw /* lua */ ''function() require("config.symbol-picker").document() end'';
      options.desc = "Document symbols (LSP)";
    }
  ];
}
