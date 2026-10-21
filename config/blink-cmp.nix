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
      # Tab accepts the highlighted menu item when the menu is open; otherwise
      # it falls through to snippet jumps, inline suggestions, then the literal Tab.
      "<Tab>" = [
        "accept"
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

    # Always highlight the first item so Tab/Enter accept it without arrow keys.
    completion.list.selection.preselect = true;
    completion.ghost_text.enabled = false;
    completion.menu.border = "single";
    completion.menu.min_width = 20;
    completion.menu.max_height = 8;
    completion.menu.draw = {
      # Anchor the menu to the start of the typed keyword (label column)
      align_to = "label";
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
