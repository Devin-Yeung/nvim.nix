{
  lib,
  ...
}:
{
  # nixpkgs supplies the Rust backend; never download/build it at editor startup.
  plugins.fff.enable = true;

  keymaps = [
    {
      mode = "n";
      key = "<leader><leader>";
      action = lib.nixvim.mkRaw /* lua */ ''function() require("fff").find_files() end'';
      options.desc = "Find files (fff)";
    }
    {
      mode = "n";
      key = "<leader>fw";
      action = lib.nixvim.mkRaw /* lua */ ''function() require("fff").live_grep() end'';
      options.desc = "Live grep (fff)";
    }
  ];
}
