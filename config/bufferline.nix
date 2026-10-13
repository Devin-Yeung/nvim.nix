{
  plugins.bufferline = {
    enable = true;
    settings = {
      options = {
        mode = "buffers";
        diagnostics = "nvim_lsp";
        separator_style = "thin";
        always_show_bufferline = true;
        show_buffer_close_icons = false;
        show_close_icon = false;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<S-h>";
      action = "<cmd>BufferLineCyclePrev<CR>";
      options.desc = "Previous buffer tab";
    }
    {
      mode = "n";
      key = "<S-l>";
      action = "<cmd>BufferLineCycleNext<CR>";
      options.desc = "Next buffer tab";
    }
    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>bdelete<CR>";
      options.desc = "Close buffer tab";
    }
  ];
}
