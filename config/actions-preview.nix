# Preview LSP code actions (the `<leader>qf` quick fix menu) as diffs before applying them.
{
  plugins.actions-preview = {
    enable = true;
    settings = {
      nui.select.win_options = {
        cursorlineopt = "both";
        winhighlight = "CursorLine:Visual";
      };
    };
  };
}
