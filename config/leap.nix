{
  plugins.leap.enable = true;

  # upstream bug: `plugins.leap.settings` never reaches the engine; set `leap.opts` directly.
  plugins.leap.luaConfig.post = ''
    local opts = require("leap.opts").default
    opts.labels = "sfjklqeioawrndctuyghpxzmb"
    opts.safe_labels = ""
    opts.offset_labels = true
  '';

  # Visual-mode `S` belongs to vim-surround, so Leap's `S` is limited to normal and operator-pending modes.
  keymaps = [
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
