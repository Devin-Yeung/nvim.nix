{ ... }:
{
  plugins.vim-suda.enable = true;

  extraConfigLuaPre = /* lua */ ''
    vim.g.suda_smart_edit = 0

    local group = vim.api.nvim_create_augroup("SudaWriteOnReadonly", { clear = true })

    vim.api.nvim_create_autocmd("BufReadPost", {
      group = group,
      pattern = "*",
      callback = function(args)
        local buf = args.buf
        local path = vim.api.nvim_buf_get_name(buf)
        -- buftype ~= "" means special buffer (nofile, terminal, ...); skip.
        -- "^%a+://" matches URL-like names (suda://, oil://, ...); skip.
        if path == "" or vim.bo[buf].buftype ~= "" or path:find "^%a+://" then
          return
        end
        -- filewritable: 1 = writable, 0 = not writable. ~= 0 is only true for 1 (or 2 for dirs).
        -- We only want: exists, readable, and NOT writable.
        if vim.fn.filereadable(path) ~= 1 or vim.fn.filewritable(path) ~= 0 then
          return
        end

        -- buffer = buf: this rule only applies to this one buffer, not globally.
        vim.api.nvim_create_autocmd("BufWriteCmd", {
          group = group,
          buffer = buf,
          callback = function()
            local file = vim.api.nvim_buf_get_name(buf)
            local tmp = vim.fn.tempname()
            -- 0, -1: first to last line. false: don't enforce strict bounds.
            -- writefile: dd can only read from a file, so dump the buffer first.
            vim.fn.writefile(vim.api.nvim_buf_get_lines(buf, 0, -1, false), tmp)
            -- vim.fn["suda#system"]: call a vim-suda function (name has '#', so bracket syntax).
            -- bs=1M: copy in 1 MiB chunks (GNU dd; BSD dd needs `1m`).
            local out = vim.fn["suda#system"]({ "dd", "if=" .. tmp, "of=" .. file, "bs=1048576" })
            -- Read shell_error immediately: the next call would overwrite it.
            local status = vim.v.shell_error
            vim.fn.delete(tmp)
            if status ~= 0 then
              error(out) -- surface sudo/dd failure; keep buffer modified
            end
            -- Only reached on success: clear the "unsaved changes" flag.
            vim.bo[buf].modified = false
          end,
        })
      end,
    })
  '';
}
