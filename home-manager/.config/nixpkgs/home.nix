
{
  # Install packages
  home.packages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    neovim
    zsh
    i3
    dmenu
    i3status
    git
    tmux
    fzf
    ghostty
  #  wget
  ];
}
