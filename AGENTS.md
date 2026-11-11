# AGENTS.md

## Repo Layout

This repo is a GNU Stow-managed dotfiles repo.

- Each top-level directory is a stow package.
- Package contents mirror their destination under `$HOME`.
- Running `make` executes `stow --target=$HOME --restow */`.

Examples:

- `nvim/.config/nvim/init.lua` becomes `~/.config/nvim/init.lua`
- `hypr/.config/hypr/hyprland.conf` becomes `~/.config/hypr/hyprland.conf`
- `zsh/.zshrc` becomes `~/.zshrc`

## Editing Rules

- Edit files in this repo, not the symlink target in `$HOME`, unless there is a specific reason not to.
- Assume files under package directories are the source of truth for the live config.
- After changing files here, the live config updates through the existing symlink.
- If a new file should exist in `$HOME`, add it in the matching package path here.

## Neovim

The active Neovim config is stored in:

- `nvim/.config/nvim/`

That directory is symlinked into:

- `~/.config/nvim/`

So when Neovim errors mention paths under `~/.config/nvim/...`, the corresponding source file in this repo is usually under `nvim/.config/nvim/...`.

## Useful Commands

- `make`: restow all packages into `$HOME`
- `make delete`: remove stowed symlinks from `$HOME`

## Notes

- Avoid editing generated plugin contents under `~/.local/share/nvim/` unless the task is specifically about installed plugin state.
- For config fixes, prefer changing the tracked source file in this repo first.
