local M = {}

M.linters_by_ft = {
  terraform = { "tflint" },
  hcl = { "tflint" },
  python = { "ruff" },
  javascript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescript = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  html = { "htmlhint" },
  c = { "clangtidy", "cppcheck", "cpplint" },
  cpp = { "clangtidy", "cppcheck", "cpplint" },
  yaml = { "yamllint" },
  ["yaml.ansible"] = { "ansible_lint", "yamllint" },
  ansible = { "ansible_lint" },
}

function M.setup()
  local lint = require "lint"
  lint.linters_by_ft = M.linters_by_ft

  vim.api.nvim_create_autocmd("BufWritePost", {
    pattern = {
      "*.tf",
      "*.tfvars",
      "*.hcl",
      "*.py",
      "*.js",
      "*.jsx",
      "*.ts",
      "*.tsx",
      "*.html",
      "*.c",
      "*.cc",
      "*.cpp",
      "*.cxx",
      "*.h",
      "*.hh",
      "*.hpp",
      "*.hxx",
      "*.yml",
      "*.yaml",
    },
    callback = function()
      lint.try_lint()
    end,
  })

  vim.api.nvim_create_autocmd({ "BufEnter", "InsertLeave" }, {
    pattern = {
      "*.py",
      "*.js",
      "*.jsx",
      "*.ts",
      "*.tsx",
      "*.html",
      "*.c",
      "*.cc",
      "*.cpp",
      "*.cxx",
      "*.h",
      "*.hh",
      "*.hpp",
      "*.hxx",
      "*.yml",
      "*.yaml",
    },
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
