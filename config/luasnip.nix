{ lib, ... }:
{
  plugins.luasnip = {
    enable = true;
    settings = {
      history = true;
      update_events = "TextChanged,TextChangedI";
    };
  };

  autoCmd = [
    {
      event = "InsertLeave";
      desc = "Unlink active LuaSnip snippets when leaving insert mode";
      callback = lib.nixvim.mkRaw ''
        function()
          local luasnip = require("luasnip")
          if luasnip.session.current_nodes[vim.api.nvim_get_current_buf()] and not luasnip.session.jump_active then
            luasnip.unlink_current()
          end
        end
      '';
    }
  ];
}
