{ ... }:
{
  # nixvim has no osc52 provider option, so set Neovim's built-in OSC 52 provider by hand.
  # Only used when no display server is present (TTY/SSH); desktop sessions keep wl-copy/xclip.
  extraConfigLua = /* lua */ ''
    if vim.env.WAYLAND_DISPLAY == nil and vim.env.DISPLAY == nil then
      local osc52 = require("vim.ui.clipboard.osc52")
      vim.g.clipboard = {
        name = "OSC 52",
        copy = { ["+"] = osc52.copy("+"), ["*"] = osc52.copy("*") },
        paste = { ["+"] = osc52.paste("+"), ["*"] = osc52.paste("*") },
      }
    end
  '';
}
