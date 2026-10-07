{ lib, ... }:
{
  plugins.lazydev.enable = true;

  # LazyDev owns its completion provider and Lua-only source registration.
  plugins.blink-cmp.settings.sources = {
    per_filetype.lua = lib.nixvim.mkRaw /* lua */ ''{ inherit_defaults = true, "lazydev" }'';
    providers.lazydev = {
      name = "LazyDev";
      module = "lazydev.integrations.blink";
      score_offset = 100;
    };
  };
}
