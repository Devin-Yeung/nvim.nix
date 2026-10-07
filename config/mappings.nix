{
  lib,
  ...
}:
{
  keymaps = [
    {
      mode = "n";
      key = "<C-h>";
      action = "<C-w>h";
      options.desc = "Switch window left";
    }
    {
      mode = "n";
      key = "<C-l>";
      action = "<C-w>l";
      options.desc = "Switch window right";
    }
    {
      mode = "n";
      key = "<C-j>";
      action = "<C-w>j";
      options.desc = "Switch window down";
    }
    {
      mode = "n";
      key = "<C-k>";
      action = "<C-w>k";
      options.desc = "Switch window up";
    }
    {
      mode = "n";
      key = "<leader>wc";
      action = "<cmd>close<CR>";
      options.desc = "Close window";
    }
    {
      mode = "n";
      key = "<leader>ws";
      action = "<cmd>split<CR>";
      options.desc = "Split window horizontally";
    }
    {
      mode = "n";
      key = "<leader>wv";
      action = "<cmd>vsplit<CR>";
      options.desc = "Split window vertically";
    }
    {
      mode = "n";
      key = "<C-s>";
      action = "<cmd>w<CR>";
      options.desc = "Save file";
    }
    {
      mode = "n";
      key = ";";
      action = ":";
      options.desc = "CMD enter command mode";
    }
    {
      mode = "i";
      key = "jk";
      action = "<Esc>";
      options.desc = "Leave insert mode";
    }
    {
      mode = "n";
      key = "<leader>/";
      action = "gcc";
      options = {
        desc = "Toggle comment";
        remap = true;
      };
    }
    {
      mode = "x";
      key = "<leader>/";
      action = "gc";
      options = {
        desc = "Toggle comment";
        remap = true;
      };
    }
    {
      mode = "n";
      key = "<Esc>";
      options.desc = "Close LSP docs, clear search highlights and multicursors";
      action = lib.nixvim.mkRaw ''
        function()
          local ok, docs = pcall(require, "noice.lsp.docs")
          if ok and docs._messages then
            for _, kind in ipairs { "hover", "signature" } do
              local msg = docs._messages[kind]
              if msg and msg:win() then
                docs.hide(msg)
              end
            end
          end
          -- Noice is optional here; native Nixvim still needs to close builtin docs.
          local preview = vim.b.lsp_floating_preview
          if preview and vim.api.nvim_win_is_valid(preview) then
            vim.api.nvim_win_close(preview, true)
          end
          if vim.api.nvim_mcursor ~= nil then
            local ns = vim.api.nvim_create_namespace "nvim.multicursor"
            vim.api.nvim_buf_clear_namespace(0, ns, 0, -1)
          end
          vim.cmd "nohlsearch"
        end
      '';
    }
    {
      mode = "n";
      key = "<C-n>";
      options.desc = "Select next occurrence (multicursor)";
      # The source uses an experimental Neovim API, not a multicursor plugin.
      action = lib.nixvim.mkRaw ''
        function()
          if vim.api.nvim_mcursor == nil then
            vim.notify("Native multicursors require a Neovim build with nvim_mcursor", vim.log.levels.WARN)
            return
          end
          local ns = vim.api.nvim_create_namespace "nvim.multicursor"
          local marks = vim.api.nvim_buf_get_extmarks(0, ns, 0, -1, {})
          vim.cmd(#marks > 0 and "normal! Qn" or "normal! Q*")
        end
      '';
    }
    {
      mode = "x";
      key = "<C-n>";
      options.desc = "Place cursor on each line of selection (multicursor)";
      action = lib.nixvim.mkRaw ''
        function()
          if vim.api.nvim_mcursor == nil then
            vim.notify("Native multicursors require a Neovim build with nvim_mcursor", vim.log.levels.WARN)
            return
          end
          vim.cmd "normal! Q"
        end
      '';
    }
  ];
}
