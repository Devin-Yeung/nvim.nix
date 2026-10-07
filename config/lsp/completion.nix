{ lib, ... }:
{
  plugins = {
    blink-cmp = {
      enable = true;
      settings = {
        snippets.preset = "luasnip";
        cmdline.enabled = true;
        appearance.nerd_font_variant = "normal";
        fuzzy = {
          implementation = "prefer_rust";
          # Nix supplies the fuzzy matcher; don't download binaries at runtime.
          prebuilt_binaries.download = false;
        };

        sources = {
          default = [
            "lsp"
            "snippets"
            "buffer"
            "path"
          ];
          per_filetype.lua = lib.nixvim.mkRaw ''{ inherit_defaults = true, "lazydev" }'';
          providers.lazydev = {
            name = "LazyDev";
            module = "lazydev.integrations.blink";
            score_offset = 100;
          };
        };

        keymap = {
          preset = "default";
          "<CR>" = [
            "accept"
            "fallback"
          ];
          "<Up>" = [
            "select_prev"
            "fallback"
          ];
          "<Down>" = [
            "select_next"
            "fallback"
          ];
          # Tab navigates snippets or inline suggestions, never accepts the menu.
          "<Tab>" = [
            "snippet_forward"
            (lib.nixvim.mkRaw ''
              function()
                return vim.lsp.inline_completion.get()
              end
            '')
            "fallback"
          ];
          "<S-Tab>" = false;
        };

        completion = {
          ghost_text.enabled = false;
          menu = {
            border = "rounded";
            min_width = 28;
            max_height = 8;
            draw = {
              # Keep the menu edge at the caret, rather than aligning the label.
              align_to = "cursor";
              padding = 1;
              gap = 2;
              columns = [
                [ "kind_icon" ]
                [
                  "label"
                  "label_description"
                ]
                [ "source_name" ]
              ];
              components = {
                label.width = {
                  max = 40;
                  fill = true;
                };
                label_description.width.max = 20;
                source_name.width.max = 8;
              };
            };
          };
          documentation = {
            auto_show = true;
            auto_show_delay_ms = 200;
            window = {
              border = "rounded";
              max_width = 64;
              max_height = 16;
              desired_min_width = 32;
              desired_min_height = 4;
              # Stack docs with the menu when possible; use sides only as a fallback.
              direction_priority = {
                menu_south = [
                  "s"
                  "n"
                  "e"
                  "w"
                ];
                menu_north = [
                  "n"
                  "s"
                  "e"
                  "w"
                ];
              };
            };
          };
        };
      };
    };

    friendly-snippets.enable = true;
    luasnip = {
      enable = true;
      settings = {
        history = true;
        update_events = "TextChanged,TextChangedI";
      };
    };
    lazydev.enable = true;
    nvim-autopairs = {
      enable = true;
      settings = {
        fast_wrap = { };
        disable_filetype = [ "vim" ];
      };
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
