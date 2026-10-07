{ lib, pkgs, ... }:
{
  # hunk.nvim uses Nui components for its diff tree.
  extraPlugins = [ pkgs.vimPlugins.nui-nvim ];

  extraFiles."lua/config/hunk.lua".source = ./lua/config/hunk.lua;

  plugins.hunk = {
    enable = true;
    settings = {
      keys.tree = {
        expand_node = [ "zo" ];
        collapse_node = [ "zc" ];
      };

      hooks = lib.nixvim.mkRaw /* lua */ ''require("config.hunk").hooks()'';
    };
  };
}
