-- Symbol pickers that list only the name and the location.
-- The kind is left out: the preview already shows what the symbol is.

local M = {}

local entry_display = require "telescope.pickers.entry_display"

-- telescope gives `[Kind] name`. gopls appends ` in <pkg>` to names.
local function symbol_name_of(item)
  local name = item.text:match "%[.-%]%s+(.*)" or item.text
  return (name:gsub(" in .*$", ""))
end

-- `show_file` is false for document symbols, where every row is in the current buffer.
local function symbol_entry_maker(show_file)
  local displayer = entry_display.create {
    separator = "  ",
    items = show_file and { { width = 20 }, { remaining = true } } or { { remaining = true } },
  }

  return function(item)
    local name = symbol_name_of(item)
    local location = vim.fn.fnamemodify(item.filename, ":.") .. ":" .. item.lnum

    return {
      value = item,
      filename = item.filename,
      lnum = item.lnum,
      col = item.col,
      -- Typing a file name should also narrow the list.
      ordinal = name .. " " .. location,
      display = function()
        if show_file then
          return displayer { name, { location, "TelescopeResultsComment" } }
        end
        return displayer { name }
      end,
    }
  end
end

M.document = function()
  require("telescope.builtin").lsp_document_symbols {
    entry_maker = symbol_entry_maker(false),
  }
end

M.workspace = function()
  require("telescope.builtin").lsp_dynamic_workspace_symbols {
    entry_maker = symbol_entry_maker(true),
  }
end

return M
