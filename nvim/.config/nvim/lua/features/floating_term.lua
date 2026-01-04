local api = vim.api
local fn = vim.fn

---@class FloatingTermState
---@field buf? number
---@field win? number
---@field job? number
---@field cwd? string

---@class FloatingTermConfig
---@field width number
---@field height number
---@field border string
---@field winblend number
---@field buf_hidden string
---@field bufname_prefix string
---@field env table?

local M = {
  _setup = false,
  opts = {
    width = 0.85,
    height = 0.65,
    border = "rounded",
    winblend = 0,
    buf_hidden = "hide",
    bufname_prefix = "FloatingTerminal",
    env = nil,
  },
  state = {
    buf = nil,
    win = nil,
    job = nil,
    cwd = nil,
  },
}

local function compute_layout()
  local columns = vim.o.columns
  local lines = vim.o.lines
  local width = math.max(20, math.floor(columns * M.opts.width))
  local height = math.max(10, math.floor(lines * M.opts.height))
  width = math.min(width, columns - 4)
  height = math.min(height, lines - 4)
  local row = math.max(0, math.floor((lines - height) / 2))
  local col = math.max(0, math.floor((columns - width) / 2))
  return {
    width = width,
    height = height,
    row = row,
    col = col,
  }
end

local function create_buffer()
  local buf = api.nvim_create_buf(false, true)
  local cwd = vim.loop.cwd()
  local job

  vim.api.nvim_buf_call(buf, function()
    job = fn.termopen(fn.getenv("SHELL") or vim.o.shell, {
      cwd = cwd,
      env = M.opts.env,
      on_exit = function(_, exit_code)
        if M.state.job == job then
          M.state.job = nil
          M.state.buf = nil
        end
        if exit_code ~= 0 then
          vim.schedule(function()
            vim.notify(("Floating terminal exited (%d)"):format(exit_code), vim.log.levels.WARN, {
              title = "FloatingTerm",
            })
          end)
        end
      end,
    })
  end)

  M.state.buf = buf
  M.state.job = job
  M.state.cwd = cwd

  api.nvim_buf_set_name(buf, ("%s://%s"):format(M.opts.bufname_prefix, cwd))
  api.nvim_buf_set_option(buf, "bufhidden", M.opts.buf_hidden)
  api.nvim_buf_set_option(buf, "filetype", "terminal")

  return buf
end

local function get_buffer()
  if M.state.buf and api.nvim_buf_is_valid(M.state.buf) and M.state.job then
    return M.state.buf
  end
  return create_buffer()
end

local function close_window()
  if M.state.win and api.nvim_win_is_valid(M.state.win) then
    api.nvim_win_close(M.state.win, true)
    M.state.win = nil
  end
end

local function open_window()
  local buf = get_buffer()
  local layout = compute_layout()
  local opts = vim.tbl_extend("force", {
    relative = "editor",
    style = "minimal",
    border = M.opts.border,
    focusable = true,
  }, layout)

  M.state.win = api.nvim_open_win(buf, true, opts)
  api.nvim_win_set_option(M.state.win, "winblend", M.opts.winblend)
  api.nvim_set_current_win(M.state.win)
  vim.cmd.startinsert()
end

local function refresh_window()
  if not (M.state.win and api.nvim_win_is_valid(M.state.win)) then
    return
  end
  local layout = compute_layout()
  local opts = {
    width = layout.width,
    height = layout.height,
    row = layout.row,
    col = layout.col,
  }
  api.nvim_win_set_config(M.state.win, vim.tbl_extend("force", opts, {
    relative = "editor",
    border = M.opts.border,
  }))
end

local function ensure_setup()
  if M._setup then
    return
  end
  M._setup = true

  local group = api.nvim_create_augroup("FloatingTermState", { clear = false })

  api.nvim_create_autocmd("VimResized", {
    group = group,
    callback = function()
      refresh_window()
    end,
  })

  api.nvim_create_autocmd("WinClosed", {
    group = group,
    callback = function(ev)
      local win = tonumber(ev.match)
      if win and M.state.win == win then
        M.state.win = nil
      end
    end,
  })

  api.nvim_create_user_command("FloatingTerm", function()
    M.toggle()
  end, {
    desc = "Toggle the floating terminal session",
  })
end

---Toggle the floating terminal. The terminal buffer (job) survives closing the float.
function M.toggle()
  ensure_setup()
  if M.state.win and api.nvim_win_is_valid(M.state.win) then
    close_window()
    return
  end
  open_window()
end

---Adjust all floating terminal windows after a resize.
function M.refresh()
  refresh_window()
end

---Configure the floating terminal before the first toggle.
---@param opts? FloatingTermConfig
function M.setup(opts)
  if opts then
    M.opts = vim.tbl_extend("force", M.opts, opts)
  end
  ensure_setup()
end

return M
