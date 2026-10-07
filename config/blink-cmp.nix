{ lib, ... }:
{
  plugins.blink-cmp.enable = true;
  plugins.blink-cmp.settings = {
    snippets.preset = "luasnip";
    cmdline.enabled = true;
    appearance.nerd_font_variant = "normal";
    appearance.kind_icons.Snippet = "‹›";
    fuzzy.implementation = "prefer_rust";
    # Nix supplies the fuzzy matcher; don't download binaries at runtime.
    fuzzy.prebuilt_binaries.download = false;

    sources.default = [
      "lsp"
      "snippets"
      "buffer"
      "path"
    ];

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
        (lib.nixvim.mkRaw /* lua */ ''
          function()
            return vim.lsp.inline_completion.get()
          end
        '')
        "fallback"
      ];
      "<S-Tab>" = false;
    };

    completion.ghost_text.enabled = false;
    completion.menu.border = "single";
    completion.menu.min_width = 20;
    completion.menu.max_height = 8;
    completion.menu.draw = {
      # Keep the menu edge at the caret, rather than aligning the label.
      align_to = "cursor";
      padding = 1;
      gap = 1;
      columns = [
        [ "label" ]
        [ "kind_icon" ]
        [ "kind" ]
      ];
      components.label.width.max = 40;
      components.label.width.fill = true;
      # Let the selection foreground override the icon color, too.
      components.kind_icon.highlight = lib.nixvim.mkRaw /* lua */ ''
        function(ctx) return ctx.kind_hl end
      '';
      components.kind.highlight = "BlinkCmpLabel";
    };

    completion.documentation.auto_show = true;
    completion.documentation.auto_show_delay_ms = 200;
    completion.documentation.window = {
      border = "single";
      max_width = 80;
      max_height = 16;
      desired_min_width = 32;
      desired_min_height = 4;
      # Prefer docs beside the menu, matching the reference layout.
      direction_priority.menu_south = [
        "e"
        "w"
        "s"
        "n"
      ];
      direction_priority.menu_north = [
        "e"
        "w"
        "n"
        "s"
      ];
    };
  };
}
