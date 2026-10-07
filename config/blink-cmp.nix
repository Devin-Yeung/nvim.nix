{ lib, ... }:
{
  plugins.blink-cmp.enable = true;
  plugins.blink-cmp.settings = {
    snippets.preset = "luasnip";
    cmdline.enabled = true;
    appearance.nerd_font_variant = "normal";
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
    completion.menu.border = "rounded";
    completion.menu.min_width = 28;
    completion.menu.max_height = 8;
    completion.menu.draw = {
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
      components.label.width.max = 40;
      components.label.width.fill = true;
      components.label_description.width.max = 20;
      components.source_name.width.max = 8;
    };

    completion.documentation.auto_show = true;
    completion.documentation.auto_show_delay_ms = 200;
    completion.documentation.window = {
      border = "rounded";
      max_width = 64;
      max_height = 16;
      desired_min_width = 32;
      desired_min_height = 4;
      # Stack docs with the menu when possible; use sides only as a fallback.
      direction_priority.menu_south = [
        "s"
        "n"
        "e"
        "w"
      ];
      direction_priority.menu_north = [
        "n"
        "s"
        "e"
        "w"
      ];
    };
  };
}
