{ lib, pkgs, ... }:
{
  # hunk.nvim uses Nui components for its diff tree.
  extraPlugins = [ pkgs.vimPlugins.nui-nvim ];

  extraFiles."lua/config/hunk.lua".source = ./lua/config/hunk.lua;

  # Lazy-loading (cmd) is provided by lz.n; nixvim requires it to be enabled.
  plugins.lz-n.enable = true;

  plugins.hunk = {
    enable = true;

    # Load on first use of the commands recommended by upstream README.
    lazyLoad = {
      enable = true;
      settings.cmd = [
        "HunkDiffView"
        "HunkDiffEditor"
      ];
    };

    settings = {
      keys.tree = {
        expand_node = [ "zo" ];
        collapse_node = [ "zc" ];
      };

      hooks = lib.nixvim.mkRaw /* lua */ ''require("config.hunk").hooks()'';
    };
  };
}
