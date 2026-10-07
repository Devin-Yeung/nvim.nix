{
  config,
  lib,
  ...
}:
{
  plugins.mini-ai = {
    enable = true;
    settings.custom_textobjects.f = lib.nixvim.mkRaw ''
      require("mini.ai").gen_spec.treesitter {
        a = "@function.outer",
        i = "@function.inner",
      }
    '';
  };

  # mini.ai's function objects need parsers and @function textobject queries.
  # Nix installs them; no lazy.nvim or runtime parser downloads are needed.
  plugins.treesitter = {
    enable = true;
    highlight.enable = true;
    grammarPackages = with config.plugins.treesitter.package.builtGrammars; [
      c
      lua
      markdown
      markdown_inline
      query
      vim
      vimdoc
      luadoc
      printf
      html
      css
      nix
      json
      toml
      rust
      jsonnet
    ];
  };
  plugins.treesitter-textobjects.enable = true;
}
