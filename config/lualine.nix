{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        globalstatus = true;
        theme = "auto";
        icons_enabled = true;
        component_separators = {
          left = "│";
          right = "│";
        };
        section_separators = {
          left = "";
          right = "";
        };
      };
      sections = {
        lualine_a = [ "mode" ];
        lualine_b = [
          "branch"
          "diff"
          "diagnostics"
        ];
        lualine_c = [
          {
            "__unkeyed-1" = "filename";
            path = 1;
          }
        ];
        # noice disables LSP progress cards, so surface progress here instead.
        lualine_x = [
          "lsp_status"
          "encoding"
          "filetype"
        ];
        lualine_y = [ "progress" ];
        lualine_z = [ "location" ];
      };
    };
  };
}
