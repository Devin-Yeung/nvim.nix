local M = {}

function M.close()
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

return M
