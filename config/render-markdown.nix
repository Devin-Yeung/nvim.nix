{ lib, ... }:
{
  # Lazy-loading (ft/keys) is provided by lz.n; nixvim requires it to be enabled.
  plugins.lz-n.enable = true;

  # render-markdown reads file icons through mini.icons (enabled in mini-icons.nix).
  plugins.render-markdown = {
    enable = true;

    # Load only for markdown buffers. The toggle key lives in the same lazy spec,
    # so pressing it before the plugin is loaded triggers the load first.
    lazyLoad = {
      enable = true;
      settings = {
        ft = [ "markdown" ];
        keys = [
          (lib.nixvim.mkRaw /* lua */ ''
            {
              "<leader>tm",
              function()
                require("render-markdown").toggle()
              end,
              desc = "Toggle render-markdown",
              ft = { "markdown" },
            }
          '')
        ];
      };
    };

    settings.bullet.icons = [
      "•"
      "◦"
      "▪"
      "▫"
    ];
  };
}
