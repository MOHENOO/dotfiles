autoload -U +X compinit && compinit
setopt COMBINING_CHARS

export XDG_CONFIG_HOME=$HOME/.config
homebrew_prefix=/opt/homebrew
export PATH="$homebrew_prefix/bin:$PATH"
export PATH="$homebrew_prefix/sbin:$PATH"
# disable forgit alias
export FORGIT_NO_ALIASES="yes"

# You can change the names/locations of these if you prefer.
antidote_dir=$HOME/.antidote
plugins_txt=$HOME/.zsh_plugins.txt
static_file=$HOME/.zsh_plugins.zsh

# Clone antidote if necessary and generate a static plugin file.
[[ ! -e $antidote_dir ]] && git clone --depth=1 https://github.com/mattmc3/antidote.git $antidote_dir
source $antidote_dir/antidote.zsh
if [[ ! $static_file -nt $plugins_txt ]]; then
  [[ -e $plugins_txt ]] || touch $plugins_txt
  antidote bundle <$plugins_txt >$static_file
fi

# Uncomment this if you want antidote commands like `antidote update` available
# in your interactive shell session:
# autoload -Uz $antidote_dir/functions/antidote

# source the static plugins file
source $static_file

# cleanup
unset antidote_dir plugins_txt static_file

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down

# mise
if [[ ! -f ~/.local/bin/mise ]];then
  curl https://mise.jdx.dev/install.sh | sh
fi
eval "$(~/.local/bin/mise activate zsh)"
export PATH="$HOME/.local/share/mise/shims:$PATH"
source <($HOME/.local/bin/mise completion zsh)

export FZF_TMUX_OPTS='-p80%,60%'

function set_dark_theme(){
    export FZF_DEFAULT_OPTS="--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"
    export BAT_THEME="Catppuccin-frappe"
    fast-theme XDG:catppuccin-frappe > /dev/null
    tmux set -g @catppuccin_flavour 'frappe'
    tmux source-file ~/.config/tmux/tmux.conf >/dev/null
    sed -i '' 's/palette = \"catppuccin_latte\"/palette = \"catppuccin_frappe\"/g' ~/Github/dotfiles/.config/starship.toml > /dev/null
    sed -i '' 's/color_theme = \"catppuccin_latte\"/color_theme = \"catppuccin_frappe\"/g' ~/Github/dotfiles/.config/btop/btop.conf > /dev/null
    sed -i '' 's/skin: catppuccin-latte/skin: catppuccin-frappe/g' ~/Github/dotfiles/.config/k9s/config.yaml > /dev/null
}

function set_light_theme(){
    export FZF_DEFAULT_OPTS="--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
    export BAT_THEME="Catppuccin-latte"
    fast-theme XDG:catppuccin-latte > /dev/null

    tmux set -g @catppuccin_flavour 'latte'
    tmux source-file ~/.config/tmux/tmux.conf >/dev/null
    sed -i '' 's/palette = \"catppuccin_frappe\"/palette = \"catppuccin_latte\"/g' ~/Github/dotfiles/.config/starship.toml > /dev/null
    sed -i '' 's/color_theme = \"catppuccin_frappe\"/color_theme = \"catppuccin_latte\"/g' ~/Github/dotfiles/.config/btop/btop.conf > /dev/null
    sed -i '' 's/skin: catppuccin-frappe/skin: catppuccin-latte/g' ~/Github/dotfiles/.config/k9s/config.yaml > /dev/null
}

function set_auto_theme() {
    # Check status of dark mode (ignore errors, i.e., when light mode is enabled).
    DARK_MODE=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
    # Return system mode.
    if [[ $DARK_MODE == "Dark" ]] ; then
      set_dark_theme
    else
      set_light_theme
    fi
}

####################################### alias ############################################
alias gst='git status'
alias tmux="tmux -u"
alias ll="eza -alig --classify --icons"
alias ls="eza --classify --icons"
alias vim=nvim
alias cat="bat -p -P"
alias ssh="TERM=xterm-256color zssh"
alias ofd='open_command $PWD'
alias tailscale="/Applications/Tailscale.app/Contents/MacOS/Tailscale"

####################################### export ###############################################
# set language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
    export EDITOR='vim'
else
    export EDITOR='nvim'
fi

## golang
export GOPATH=$HOME/Development/go
export GOBIN=$GOPATH/bin
export PATH=$GOBIN:$PATH

#### llvm
if [[ -f $homebrew_prefix/opt/llvm/bin/clang ]]; then
  export PATH="$homebrew_prefix/opt/llvm/bin:$PATH"
  export LDFLAGS="-L$homebrew_prefix/opt/llvm/lib"
  export CPPFLAGS="-I$homebrew_prefix/opt/llvm/include"
fi
#### make
[ -f $homebrew_prefix/opt/make/bin/make ] && export PATH="$homebrew_prefix/opt/make/libexec/gnubin:$PATH"

## other
export SSH_AUTH_SOCK=~/Library/Group\ Containers/2BUA8C4S2C.com.1password/t/agent.sock
export ZSSHESCAPE='^G'

# tmux color
# if [[ $TMUX != "" ]] then
#     export TERM="tmux-256color"
# else
#     export TERM="xterm-256color"
# fi
export TERM="xterm-256color"

# zoxide
eval "$(zoxide init zsh)"
# starship
eval "$(starship init zsh)"

export PATH=${HOME}/.local/bin:$PATH

# kubectl
source <(kubectl completion zsh)
# kind
#source <(kind completion zsh)
# kubebuilder
#source <(kubebuilder completion zsh)

# forgit
export PATH="$PATH:$FORGIT_INSTALL_DIR/bin"

function brew() {
  command brew "$@"

  if [[ $* =~ "upgrade" ]] || [[ $* =~ "update" ]] || [[ $* =~ "outdated" ]]; then
    sketchybar --trigger brew_update
  fi
}

function zen () {
  ~/.config/sketchybar/plugins/zen.sh $1
}

function proxy () {
  export http_proxy=http://127.0.0.1:1087;export https_proxy=http://127.0.0.1:1087;export ALL_PROXY=socks5://127.0.0.1:1087
}
function unproxy () {
  unset http_proxy && unset https_proxy && unset ALL_PROXY
}

function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

function update_terminfo () {
    local x ncdir terms
    ncdir="$homebrew/opt/ncurses"
    terms=(alacritty-direct alacritty tmux tmux-256color)

    mkdir -p ~/.terminfo && cd ~/.terminfo

    if [ -d $ncdir ] ; then
        # sed : fix color for htop
        for x in $terms ; do
            $ncdir/bin/infocmp -x -A $ncdir/share/terminfo $x > ${x}.src &&
            sed -i '' 's|pairs#0x10000|pairs#32767|' ${x}.src &&
            /usr/bin/tic -x ${x}.src &&
            rm -f ${x}.src
        done
    else
        local url
        url="https://invisible-island.net/datafiles/current/terminfo.src.gz"
        if curl -sfLO $url ; then
            gunzip -f terminfo.src.gz &&
            sed -i '' 's|pairs#0x10000|pairs#32767|' terminfo.src &&
            /usr/bin/tic -xe ${(j:,:)terms} terminfo.src &&
            rm -f terminfo.src
        else
            echo "unable to download $url"
        fi
    fi
    cd - > /dev/null
}

# if [ -n "$PS1" ] && [ -z "$TMUX" ]; then
#   tmuxinator start terminal
# fi

# remote docker
# export DOCKER_HOST="tcp://192.168.100.103"

unset homebrew_prefix

unalias grep

export KUBECONFIG=~/.kube/config:~/Work/kubeconfig:~/.kube/kind_config

# atuin
export ATUIN_NOBIND="true"
eval "$(atuin init zsh)"
bindkey '^r' atuin-search
source <(atuin gen-completions -s zsh)
set_auto_theme 2> /dev/null

# k9s
export K9S_CONFIG_DIR=$HOME/.config/k9s
