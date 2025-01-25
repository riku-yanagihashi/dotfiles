return {
  -- LSP設定
  {
    "neovim/nvim-lspconfig",
    config = function()
      local lspconfig = require("lspconfig")

      -- OmniSharpの設定
      lspconfig.omnisharp.setup({
        cmd = { "/path/to/omnisharp-roslyn/OmniSharp", "--languageserver" },
        root_dir = lspconfig.util.root_pattern(".sln", ".csproj", ".git"),
        settings = {
          omnisharp = {
            enableEditorConfigSupport = true,
            enableRoslynAnalyzers = true,
          },
        },
      })
    end,
  },

  -- テストフレームワーク統合例
  {
    "vim-test/vim-test",
    config = function()
      vim.g["test#strategy"] = "neovim"
      vim.g["test#javascript#runner"] = "jest"
    end,
  },
}
