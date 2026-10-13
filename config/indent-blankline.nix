{
  extraConfigLuaPre = ''
    local hooks = require("ibl.hooks")

    -- Hide the leftmost guide column, which runs through the whole file and adds noise.
    hooks.register(hooks.type.WHITESPACE, hooks.builtin.hide_first_space_indent_level)

    -- Link to existing OneDark groups (themes/onedark.lua) so guides stay muted and follow the palette.
    -- HIGHLIGHT_SETUP runs inside ibl.setup() before ibl copies these groups, and again on ColorScheme.
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      vim.api.nvim_set_hl(0, "IblIndent", { link = "WinSeparator" }) -- #31353d
      vim.api.nvim_set_hl(0, "IblScope", { link = "LineNr" }) -- #42464e
    end)
  '';

  plugins.indent-blankline = {
    enable = true;
    settings = {
      indent = {
        char = "│";
        highlight = "IblIndent";
      };
      scope = {
        enabled = true;
        highlight = "IblScope";
        show_start = false;
        show_end = false;
      };
    };
  };
}
