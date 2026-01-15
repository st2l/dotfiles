return {
  "AstroNvim/astrolsp",
  opts = {
    servers = {
      "basedpyright",
      "gopls",
    },
    config = {
      gopls = {
        settings = {
          gopls = {
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            analyses = {
              unusedparams = true,
              shadow = true,
            },
            staticcheck = true,
          },
        },
      },
    },
  },
}
