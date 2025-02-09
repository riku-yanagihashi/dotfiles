local cmp_nvim_lsp_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_ok then
  cmp_nvim_lsp = {
    default_capabilities = function()
      return {}
    end,
  }
end

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        omnisharp = {
          cmd = { vim.fn.stdpath("data") .. "/mason/bin/omnisharp" },
          filetypes = { "cs", "vb" },
          root_dir = function(fname)
            return require("lspconfig.util").root_pattern("*.sln", "*.csproj")(fname)
              or require("lspconfig.util").find_git_ancestor(fname)
          end,
          capabilities = cmp_nvim_lsp.default_capabilities(),
        },
      },
    },
  },
}
