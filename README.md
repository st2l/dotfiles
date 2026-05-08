# dotfiles

Each top-level directory is a standalone GNU Stow package.

Examples:

```bash
stow data
stow nvim zsh tmux
stow kitty presenterm
stow pwninit
```

Package targets:

- `data` -> `~/.local/share/dotfiles-data/...`
- `kitty` -> `~/.config/kitty/...`
- `nvim` -> `~/.config/nvim/...`
- `presenterm` -> `~/.config/presenterm/...`
- `pwninit` -> `~/.local/bin/...` and `~/.local/share/pwninit/...`
- `tmux` -> `~/.tmux.conf`
- `zsh` -> `~/.zshrc` and `~/.p10k.zsh`

Notes:

- If a target already exists on the machine, unstow or back it up before stowing this repo.
