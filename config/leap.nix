{
  plugins.leap = {
    enable = true;
    settings = {
      labels = "sfjklqeioawrndctuyuighthpxzmb";
      safe_labels = "";
    };
  };

  # vim-surround installs visual S during plugin loading. Register afterward
  # so Leap keeps S in all three modes, as in the source's lazy.nvim keys.
  keymapsOnEvents.VimEnter = [
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action = "<Plug>(leap-forward)";
      options.desc = "Leap forward to";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "S";
      action = "<Plug>(leap-backward)";
      options.desc = "Leap backward to";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "gs";
      action = "<Plug>(leap-from-window)";
      options.desc = "Leap from window";
    }
  ];
}
