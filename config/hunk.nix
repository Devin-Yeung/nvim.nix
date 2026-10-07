{ lib, pkgs, ... }:
{
  # hunk.nvim uses Nui components for its diff tree.
  extraPlugins = [ pkgs.vimPlugins.nui-nvim ];

  plugins.hunk = {
    enable = true;
    settings = {
      keys.tree = {
        expand_node = [ "zo" ];
        collapse_node = [ "zc" ];
      };

      hooks = {
        on_tree_mount = lib.nixvim.mkRaw /* lua */ ''
          ---@param ctx { buf: number, tree: any, opts: table }
          function(ctx)
            vim.wo[ctx.opts.winid].wrap = false
            vim.wo[ctx.opts.winid].linebreak = false

            -- on_toggle calls this as `opts.tree.render()` (no self), so mimic Component.
            local function render_tree()
              ctx.tree:render()
            end
            local cb = { tree = { render = render_tree } }

            -- `a` is normal-mode only upstream; add visual mode (file nodes only).
            vim.keymap.set("x", "a", function()
              -- `'<`/`'>` are unset inside an x-mode mapping; use `v` and `.`.
              local first, last = vim.fn.line "v", vim.fn.line "."
              if first > last then
                first, last = last, first
              end

              for line = first, last do
                local node = ctx.tree:get_node(line)
                if node and node.type == "file" then
                  ctx.opts.on_toggle(node.change, nil, cb)
                end
              end

              vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)
            end, { buffer = ctx.buf, nowait = true, desc = "Toggle files in selection" })
          end
        '';
        on_diff_mount = lib.nixvim.mkRaw /* lua */ ''
          function(ctx)
            vim.wo[ctx.win].wrap = false
            vim.wo[ctx.win].linebreak = false
          end
        '';
      };
    };
  };
}
