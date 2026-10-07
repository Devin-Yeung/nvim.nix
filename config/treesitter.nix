{ config, ... }:
{
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
      go
    ];
  };
}
