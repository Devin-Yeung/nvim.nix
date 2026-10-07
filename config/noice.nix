{ lib, ... }:
{
  # Noice's notification view is backed by nvim-notify; Nui provides its UI primitives.
  plugins.notify.enable = true;

  plugins.noice = {
    enable = true;
    settings = {
      notify.enabled = true;
      cmdline = {
        enabled = true;
        view = "cmdline";
      };
      presets.lsp_doc_border = true;

      # Avoid per-keystroke progress cards; the statusline shows LSP progress.
      lsp.progress.enabled = false;
    };
  };

  # Noice sets cmdheight to zero during setup, collapsing the gap below the
  # statusline. This runs after plugin setup and restores that gap.
  extraConfigLua = /* lua */ ''
    vim.schedule(function()
      vim.opt.cmdheight = 1
    end)
  '';

  # <C-b> is Herdr's prefix; use <C-d>/<C-u> for documentation scrolling.
  keymaps = [
    {
      mode = [
        "n"
        "i"
        "s"
      ];
      key = "<C-d>";
      action = lib.nixvim.mkRaw /* lua */ ''
        function()
          if not require("noice.lsp").scroll(4) then
            return "<C-d>"
          end
        end
      '';
      options = {
        desc = "Scroll LSP doc down";
        expr = true;
        silent = true;
      };
    }
    {
      mode = [
        "n"
        "i"
        "s"
      ];
      key = "<C-u>";
      action = lib.nixvim.mkRaw /* lua */ ''
        function()
          if not require("noice.lsp").scroll(-4) then
            return "<C-u>"
          end
        end
      '';
      options = {
        desc = "Scroll LSP doc up";
        expr = true;
        silent = true;
      };
    }
  ];
}
