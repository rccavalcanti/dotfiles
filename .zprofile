#
# ~/.zprofile
#
# Author: Rafael Cavalcanti - rafaelc.org

# User flatpaks
if [ -d "$HOME/.local/share/flatpak/exports/bin" ]; then
	PATH="$HOME/.local/share/flatpak/exports/bin:$PATH"
fi

# User's private bin
if [ -d "$HOME/.local/bin" ] ; then
	PATH="$HOME/.local/bin:$PATH"
fi

# Termux: User's private bin
if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
fi

# Rubygem user's bin
if command -v ruby >/dev/null; then
	PATH="$(ruby -e 'puts Gem.user_dir')/bin:$PATH"
fi

# Spicetify
if [[ -d "$HOME/.local/opt/spicetify-cli" ]]; then
	export SPICETIFY_INSTALL="$HOME/.local/opt/spicetify-cli"
	export PATH="$SPICETIFY_INSTALL:$PATH"
fi

# Termux: Set runtime dir
if [[ "$HOST" == "localhost" && -z "$XDG_RUNTIME_DIR" ]]; then
	export XDG_RUNTIME_DIR="$PREFIX/var/run"
fi

# Termux: Start OpenSSH agent if needed
if [[ "$HOST" == "localhost" && -z "$SSH_AUTH_SOCK" ]]; then
	export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"
	rm -f "$SSH_AUTH_SOCK"
	ssh-agent -t 1h -a "$SSH_AUTH_SOCK" > /dev/null
fi

# Termux: if connected via SSH, grab wake-lock
if [[ "$HOST" == "localhost" && -n "$SSH_CLIENT" ]]; then
	printf "Grabbing wake-lock...\n" 1>&2
	termux-wake-lock
fi

# WSL: fix umask
if [[ "$(umask)" == "0000" ]]; then
	umask 0027
fi

# Make Qt use GTK style
# Be sure to install qt5-style-plugins
if [[ -n $DISPLAY ]]; then
	export QT_QPA_PLATFORMTHEME=gtk2
fi

# Check slow host
if [[ " pi pi-vcc pizero " =~ " $HOST " ]]; then
	export SLOW_HOST=true
else
	export SLOW_HOST=false
fi

# Paths
export ALIASES="$HOME/.config/aliases"
export WALLPAPERS="$HOME/Pictures/Wallpapers/Desktop/"

# Default applications
export EDITOR="vim"
export TERMINAL="alacritty"

# Applications configuration
export MPD_HOST="192.168.15.101"
export FZF_DEFAULT_OPTS="--layout=reverse --height 40%"
export FZF_DEFAULT_COMMAND="rg --files --hidden"

# Zsh configuration
# Needed for last-working-dir plugin; and I use it in other places
export ZSH_CACHE_DIR="$HOME/.cache/zsh"
mkdir -p "$ZSH_CACHE_DIR"
# Move from ~/
export ZDOTDIR="$HOME/.config/zsh"
export ADOTDIR="$ZSH_CACHE_DIR/antigen"
