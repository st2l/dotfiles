local M = {}

M.linters_by_ft = {
  c = { "cpplint" },
  cpp = { "cpplint" },
}

function M.setup()
  local lint = require "lint"
  lint.linters_by_ft = M.linters_by_ft

  local lint_group = vim.api.nvim_create_augroup("UserCpplintOnSave", { clear = true })

  vim.api.nvim_create_autocmd("BufWritePost", {
    group = lint_group,
    pattern = { "*.c", "*.cc", "*.cpp", "*.cxx", "*.h", "*.hh", "*.hpp", "*.hxx" },
    callback = function()
      lint.try_lint()
    end,
  })
end

return M
