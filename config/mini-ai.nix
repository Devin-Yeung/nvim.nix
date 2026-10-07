{ lib, ... }:
{
  plugins.mini-ai = {
    enable = true;
    settings.custom_textobjects.f = lib.nixvim.mkRaw /* lua */ ''
      require("mini.ai").gen_spec.treesitter {
        a = "@function.outer",
        i = "@function.inner",
      }
    '';
  };
}
