{
  plugins.lualine = {
    enable = true;
    settings = {
      options = {
        globalstatus = true;
        # Colors copied from NvChad's base46 statusline (St_* groups)
        theme =
          let
            body = {
              bg = "#22262e";
              fg = "#abb2bf";
            };
            mode = bg: {
              a = {
                inherit bg;
                fg = "#1e222a";
                gui = "bold";
              };
              b = body;
              c = body;
            };
          in
          {
            normal = mode "#81a1c1";
            insert = mode "#c882e7";
            visual = mode "#a3b8ef";
            replace = mode "#fca2aa";
            command = mode "#98c379";
            terminal = mode "#98c379";
            inactive = {
              a = {
                bg = "#1b1f27";
                fg = "#6f737b";
              };
              b = {
                bg = "#1b1f27";
                fg = "#6f737b";
              };
              c = {
                bg = "#1b1f27";
                fg = "#6f737b";
              };
            };
          };
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
