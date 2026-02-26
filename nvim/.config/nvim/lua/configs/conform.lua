local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    go = { "goimports", "gofmt" },
    terraform = { "terraform_fmt" },
    ["terraform-vars"] = { "terraform_fmt" },
    javascript = { "prettierd", "prettier" },
    javascriptreact = { "prettierd", "prettier" },
    typescript = { "prettierd", "prettier" },
    typescriptreact = { "prettierd", "prettier" },
    html = { "prettierd", "prettier" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
