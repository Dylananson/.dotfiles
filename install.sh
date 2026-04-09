#!/bin/bash
set -e

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

backup_conflict() {
    local target_path="$1"
    local backup_path
    local backup_index=1

    if [ ! -e "$target_path" ] && [ ! -L "$target_path" ]; then
        return
    fi

    backup_path="${target_path}.old"
    while [ -e "$backup_path" ] || [ -L "$backup_path" ]; do
        backup_path="${target_path}.old.${backup_index}"
        backup_index=$((backup_index + 1))
    done

    mv -- "$target_path" "$backup_path"
    echo "Backed up: $target_path -> $backup_path"
}

OMARCHY_CONFLICT_PATHS=(
    ".config/ghostty"
    ".config/waybar"
    ".config/walker"
    ".config/mako"
    ".config/alacritty"
    ".config/kitty"
)

would_conflict_with_omarchy() {
    local target_rel="$1"
    local omarchy_path

    for omarchy_path in "${OMARCHY_CONFLICT_PATHS[@]}"; do
        if [ "$target_rel" = "$omarchy_path" ] || [[ "$target_rel" == "$omarchy_path"/* ]]; then
            return 0
        fi
    done
    return 1
}

backup_stow_conflicts() {
    local package_dir source_path target_rel target_path
    local -A backed_up=()

    for package_dir in "$DOTFILES_DIR"/*/; do
        [ -d "$package_dir" ] || continue

        while IFS= read -r -d '' source_path; do
            target_rel="${source_path#"$package_dir"}"
            target_path="$HOME/$target_rel"

            if ! would_conflict_with_omarchy "$target_rel"; then
                continue
            fi

            if [ -e "$target_path" ] || [ -L "$target_path" ]; then
                if [ -z "${backed_up["$target_path"]}" ]; then
                    backup_conflict "$target_path"
                    backed_up["$target_path"]=1
                fi
            fi
        done < <(find "$package_dir" -mindepth 1 -print0)
    done
}

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

# 4. Backup anything that would conflict with stow.
backup_stow_conflicts

# 5. Link dotfiles via stow
cd "$DOTFILES_DIR"
stow --verbose --target="$HOME" --restow */

# 6. For Hyprland: omarchy's hyprland.conf sources your custom.conf
echo "" >> "$HOME/.config/hypr/hyprland.conf"
echo "source = ~/.config/hypr/hyprland.custom.conf" >> "$HOME/.config/hypr/hyprland.conf"

echo "Done! Restart Hyprland."
