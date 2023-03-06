#!/bin/bash

# Install xCode cli tools
echo "Installing commandline tools..."
xcode-select --install

# Install Brew
echo "Installing Brew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

homebrew_prefix=/usr/local
[[ -f /opt/homebrew/bin/brew ]] && homebrew_prefix=/opt/homebrew
export PATH="$homebrew_prefix/bin:$PATH"
export PATH="$homebrew_prefix/sbin:$PATH"
brew analytics off

# Brew Taps
echo "Installing Brew Formulae..."
brew tap homebrew/cask-fonts
brew tap FelixKratz/formulae
brew tap golangci/tap

# Brew Formulae
brew install stow
brew install bash
brew install zsh
brew install atuin
brew install btop
brew install mercurial
brew install llvm
brew install tmux
brew install tmuxinator
brew install starship
brew install fontconfig
brew install rust
brew install git
brew install eza
brew install bat
brew install fd
brew install ag
brew install rg
brew install grep
brew install pngpaste
brew install coreutils
brew install curl
brew install wget
brew install nodejs
brew install cmake
brew install marked
brew install koekeishiya/formulae/yabai
brew install koekeishiya/formulae/skhd
brew install felixkratz/formulae/sketchybar
brew install zssh
brew install glslang
brew install zoxide
brew install kubectl
brew install kubectx
brew install derailed/k9s/k9s
brew install docker
brew install jq
brew install switchaudio-osx
brew install bear
brew install neofetch
brew install shfmt
brew install shellcheck
brew install neovim
brew install gcc
brew install libgccjit
brew install golangci/tap/golangci-lint
brew install borders
brew install git-delta
brew install yazi ffmpegthumbnailer unar jq poppler fd ripgrep zoxide

# Brew Casks
echo "Installing Brew Casks..."
## font
brew install --cask font-meslo-lg-nerd-font
brew install --cask font-fira-code-nerd-font
brew install --cask font-sauce-code-pro-nerd-font
brew install --cask font-hack-nerd-font
brew install --cask font-overpass-nerd-font
brew install --cask sf-symbols
brew install --cask font-monaspace-nerd-font
## terminal
brew install --cask wezterm
## media
brew install --cask plex
brew install --cask plexamp
brew install --cask emby
brew install --cask google-chrome
brew install --cask arc
brew install --cask lastfm
## vpn
brew install --cask tailscale
## stream
brew install --cask moonlight
brew install --cask parsec
## dev tools
brew install --cask visual-studio-code
## tools
brew install --cask 1password
brew install --cask raycast
brew install --cask betterdisplay
brew install --cask espanso
brew install --cask squirrel
brew install --cask obsidian
brew install --cask the-unarchiver
brew install --cask wechat
brew install --cask hiddenbar
## mouse
brew install --cask logi-options-plus

# Git Clone Repo
## Tpm
mkdir -p ~/.config/tmux/plugins
[ ! -d "$HOME/.config/tmux/plugins/tpm" ] && git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
## mise
curl https://mise.jdx.dev/install.sh | sh

## Installing Fonts
curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v1.0.4/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf

# Copying and checking out configuration files
echo "Planting Configuration Files..."
mkdir -p $HOME/Github
[ ! -d "$HOME/Github/dotfiles" ] && git clone --depth=1 https://github.com/mohenoo/dotfiles.git $HOME/Github/dotfiles
mkdir -p $HOME/.config
mkdir -p $HOME/.ssh
[ ! -d "$HOME/.ssh/config" ] && cp $HOME/Github/dotfiles/.ssh/config $HOME/.ssh/config
[ ! -d "$HOME/.gitconfig" ] && cp $HOME/Github/dotfiles/.gitconfig $HOME/.gitconfig
stow -v --target $HOME .

# bat install Catppuccin theme
mkdir -p "$(bat --config-dir)/themes"
git clone https://github.com/catppuccin/bat.git
cp bat/*.tmTheme "$(bat --config-dir)/themes"
bat cache --build

# delta install Catppuccin theme
# wait issue https://github.com/catppuccin/catppuccin/issues/2246
git clone https://github.com/Anomalocaridid/delta ~/.config/delta

# fsh install Catppuccin theme
mkdir -p ~/.config/fsh/
git clone https://github.com/catppuccin/zsh-fsh.git
cp zsh-fsh/themes/* ~/.config/fsh/
fast-theme XDG:catppuccin-frappe

# btop install Catppuccin theme
mkdir -p ~/.config/btop/themes
git clone https://github.com/catppuccin/btop.git
cp btop/themes/* ~/.config/btop/themes/

# atuin sync
# ln -sf ~/Github/dotfiles/.config/atuin/config.toml ~/.config/atuin/config.toml
atuin login -u mohenoo
atuin sync

# run source manually
# source $HOME/.zshrc

# Start Services
echo "Starting Services (grant permissions)..."
brew services start sketchybar
brew services start borders

csrutil status
echo "Do not forget to disable SIP"
echo "Add sudoer yabai manually:\n '$(whoami) ALL = (root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | awk "{print \$1;}") $(which yabai) --load-sa' to '/private/etc/sudoers.d/yabai'"
echo "Installation complete...\n"

## start yabai and skhd
# yabai --start-service
# skhd --start-service
