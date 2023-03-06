#!/bin/env sh
homebrew_prefix=/opt/homebrew
export PATH="$homebrew_prefix/bin:$PATH"
export PATH="$homebrew_prefix/sbin:$PATH"
set_auto_theme() {
	# Check status of dark mode (ignore errors, i.e., when light mode is enabled).
	DARK_MODE=$(defaults read -g AppleInterfaceStyle 2>/dev/null)
	# Return system mode.
	if [ $DARK_MODE = "Dark" ]; then
		set_dark_theme
	else
		set_light_theme
	fi
}

set_dark_theme() {
	export FZF_DEFAULT_OPTS="--color=bg+:#414559,bg:#303446,spinner:#f2d5cf,hl:#e78284 --color=fg:#c6d0f5,header:#e78284,info:#ca9ee6,pointer:#f2d5cf --color=marker:#f2d5cf,fg+:#c6d0f5,prompt:#ca9ee6,hl+:#e78284"
	export BAT_THEME="Catppuccin-frappe"
	fast-theme XDG:catppuccin-frappe
	tmux set -g @catppuccin_flavour 'frappe'
	tmux source-file ~/.config/tmux/tmux.conf >/dev/null
	sed -i '' 's/palette = \"catppuccin_latte\"/palette = \"catppuccin_frappe\"/g' ~/Github/dotfiles/.config/starship.toml
	sed -i '' 's/color_theme = \"catppuccin_latte\"/color_theme = \"catppuccin_frappe\"/g' ~/Github/dotfiles/.config/btop/btop.conf >/dev/null
	sed -i '' 's/skin: catppuccin-latte/skin: catppuccin-frappe/g' ~/Github/dotfiles/.config/k9s/config.yaml >/dev/null
}

set_light_theme() {
	export FZF_DEFAULT_OPTS="--color=bg+:#ccd0da,bg:#eff1f5,spinner:#dc8a78,hl:#d20f39 --color=fg:#4c4f69,header:#d20f39,info:#8839ef,pointer:#dc8a78 --color=marker:#dc8a78,fg+:#4c4f69,prompt:#8839ef,hl+:#d20f39"
	export BAT_THEME="Catppuccin-latte"
	fast-theme XDG:catppuccin-latte
	tmux set -g @catppuccin_flavour 'latte'
	tmux source-file ~/.config/tmux/tmux.conf >/dev/null
	sed -i '' 's/palette = \"catppuccin_frappe\"/palette = \"catppuccin_latte\"/g' ~/Github/dotfiles/.config/starship.toml
	sed -i '' 's/color_theme = \"catppuccin_frappe\"/color_theme = \"catppuccin_latte\"/g' ~/Github/dotfiles/.config/btop/btop.conf >/dev/null
	sed -i '' 's/skin: catppuccin-frappe/skin: catppuccin-latte/g' ~/Github/dotfiles/.config/k9s/config.yaml >/dev/null
}

set_auto_theme 2>/dev/null
