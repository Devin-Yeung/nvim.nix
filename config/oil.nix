{
  lib,
  ...
}:
{
  plugins.oil = {
    enable = true;
    settings = {
      skip_confirm_for_simple_edits = true;
      view_options = {
        show_hidden = true;
        is_always_hidden = lib.nixvim.mkRaw ''
          function(name, _)
            return name == ".." or name == ".git"
          end
        '';
      };
      keymaps = {
        gd = {
          "__unkeyed-1" = "actions.select";
          mode = "n";
          desc = "Enter dir / open file";
        };
        "<C-o>" = {
          "__unkeyed-1" = "actions.parent";
          mode = "n";
          desc = "Go to parent dir";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "-";
      action = "<cmd>Oil<CR>";
      options.desc = "Open oil for current dir";
    }
  ];
}
