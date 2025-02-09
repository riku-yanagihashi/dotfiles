-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

local unity_config = vim.fn.expand("~/.config/nvim-unity")

if vim.fn.isdirectory(unity_config) == 1 then
    vim.opt.runtimepath:append(unity_config)
end


-- Neovim-Unity の LSP 設定があれば追加
local unity_lsp_path = "~/.config/nvim-unity/lua/lsp.lua"
if vim.fn.filereadable(vim.fn.expand(unity_lsp_path)) == 1 then
    dofile(vim.fn.expand(unity_lsp_path))
end


