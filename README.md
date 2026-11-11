# Prerequistes
sudo apt-get install stow
sudo apt-get install make 

## Instructions
- make sure to delete the conflict config files before running make
- run `make`

## WireGuard
- WireGuard docs live in `wireguard/.config/wireguard/README.md`
- Final setup uses `/etc/wireguard/wg0.conf` with `wg-quick@wg0`
- After stowing, the docs are also available at `~/.config/wireguard/README.md`


## This doesn't install anything so we would need to install 
- feh (this is for setting backgrounds)
    - auto set background in i3 config using feg --bg-scale
- compton (this is for transparrent background)
- arandr (gui for screens)

- fonts
```
    mkdir -p ~/.local/share/fonts
    cd ~/.local/share/fonts && curl -fLO https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/DroidSansMNerdFont-Regular.otf
```


- lazygit (optional)
- zsh  
- nvim  
- lsps for nvim 
- need to and install packer plugins  

