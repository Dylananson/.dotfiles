#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

# 1. Install required packages
PACKAGES=(
    zsh
    fzf
    neovim
    ghostty
    hyprland
    tmux
    emacs
)

for pkg in "${PACKAGES[@]}"; do
    if ! omarchy-pkg-installed "$pkg" &> /dev/null; then
        omarchy-pkg-add "$pkg"
    fi
done

# 2. Install Nerd Font
mkdir -p ~/.local/share/fonts
if [ ! -f ~/.local/share/fonts/DroidSansMNerdFont-Regular.otf ]; then
    curl -fLo ~/.local/share/fonts/DroidSansMNerdFont-Regular.otf \
        https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
fi

# 3. Install oh-my-zsh (keep original .zshrc)
ZSHRC_BACKUP=""
if [ -f "$HOME/.zshrc" ]; then
    ZSHRC_BACKUP=$(mktemp)
    cp "$HOME/.zshrc" "$ZSHRC_BACKUP"
fi
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi
if [ -n "$ZSHRC_BACKUP" ]; then
    cp "$ZSHRC_BACKUP" "$HOME/.zshrc"
    rm "$ZSHRC_BACKUP"
fi

# 4. Backup existing system configs (rename with .old)
# BACKUPS=(
#     "$HOME/.tmux.conf"
#     "$HOME/.zshrc"
#     "$HOME/.zsh_profile"
#     "$HOME/.bashrc"
#     "$HOME/.config/nvim"
#     "$HOME/.config/ghostty/config"
# )
#
# for file in "${BACKUPS[@]}"; do
#     if [ -e "$file" ]; then
#         mv "$file" "${file}.old"
#         echo "Backed up: $file → ${file}.old"
#     fi
# done
#
# 5. Link dotfiles via stow
cd "$DOTFILES_DIR"
stow --verbose --target="$HOME" --restow */

# 6. For Hyprland: omarchy's hyprland.conf sources your custom.conf
echo "" >> "$HOME/.config/hypr/hyprland.conf"
echo "source = ~/.config/hypr/hyprland.custom.conf" >> "$HOME/.config/hypr/hyprland.conf"

echo "Done! Restart Hyprland."
