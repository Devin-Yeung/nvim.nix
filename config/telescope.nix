{ lib, ... }:
{
  # Picker for LSP definitions: selecting an entry jumps there and closes the picker.
  plugins.telescope.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "gd";
      action = lib.nixvim.mkRaw /* lua */ ''function() require("telescope.builtin").lsp_definitions() end'';
      options.desc = "Go to definition (picker)";
    }
  ];
}
