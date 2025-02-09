local function cmd(command)
  return table.concat({ "<cmd>", command, "<CR>" })
end

local map = vim.keymap.set
local del = vim.keymap.del

-- buffer cycle
del("n", "<S-h>")
del("n", "<S-l>")





-- del move lines
del("n", "<A-j>")
del("n", "<A-k>")
del("i", "<A-j>")
del("i", "<A-k>")
del("v", "<A-j>")
del("v", "<A-k>")

del({ "i", "n" }, "<esc>")
map("n", "<leader>h", cmd("noh"))

-- FzfLua
map("n", "<leader>\\", cmd("FzfLua grep_curbuf"))
map("n", "<leader>se", cmd("FzfLua diagnostics_workspace severity_limit=2"), { desc = "Warn Diagnostics" })
map("n", "<leader>sE", cmd("FzfLua diagnostics_workspace severity_limit=1"), { desc = "Error Diagnostics" })

-- Lsp
map({ "n", "v" }, "ga", vim.lsp.buf.code_action, { desc = "Code action" })

-- `using` の自動追加
map("n", "<leader>oi", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.title:match("Add 'using'")
    end,
    apply = true,
  })
end, { desc = "Organize Imports (Add missing using)" })

-- 不要な `using` を削除するショートカット
vim.keymap.set("n", "<leader>ou", function()
  vim.lsp.buf.code_action({
    filter = function(action)
      return action.title:match("Remove Unnecessary Usings")
    end,
    apply = true,
  })
end, { desc = "Remove unnecessary usings" })


-- フォーマット (C# のコードを `dotnet format` で整える)
map("n", "<leader>f", function()
  vim.lsp.buf.format()
end, { desc = "Format code" })

-- Code Action のポップアップサイズを拡大
vim.lsp.handlers["textDocument/codeAction"] = vim.lsp.with(vim.lsp.handlers.code_action, {
  border = "rounded", -- ボーダーを角丸に
  width = 80,         -- 横幅を 80 に設定
  height = 20,        -- 高さを 20 に設定
})


-- Toggle statusline
map("n", "<leader>uS", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.laststatus:get() == 0 then
    vim.opt.laststatus = 3
  else
    vim.opt.laststatus = 0
  end
end, { desc = "Toggle Statusline" })

-- Toggle tabline
map("n", "<leader>u<tab>", function()
  ---@diagnostic disable-next-line: undefined-field
  if vim.opt.showtabline:get() == 0 then
    vim.opt.showtabline = 2
  else
    vim.opt.showtabline = 0
  end
end, { desc = "Toggle Tabline" })

-- Deleting without yanking empty line
map("n", "dd", function()
  return vim.api.nvim_get_current_line():match("^$") ~= nil and '"_dd' or "dd"
end, { noremap = true, expr = true, desc = "Don't yank empty line to clipboard" })

-- delete key somethings
del("n", "<leader>l")
del("n", "<leader>L")
del("n", "<leader>K")
del("n", "<leader>|")
del("n", "<leader>-")
del("n", "<leader>`")

map("n", "<leader><c-_>", function()
  ---@diagnostic disable-next-line: redundant-parameter
  Snacks.terminal(nil, { cwd = vim.fn.expand("%:p:h") })
end, { desc = "Open Terminal with current dir" })

map("v", "<leader>cn", ":CarbonNow<CR>", { silent = true })
