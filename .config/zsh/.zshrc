# ~/.zshrc
# Author: Rafael Cavalcanti - rafaelc.org

# =================================================================
# From oh-my-zsh
# =================================================================

# Path to your oh-my-zsh installation.
export ZSH="$ZDOTDIR/oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# [RC added] Spaceship theme configuration
SPACESHIP_DIR_COLOR="blue"
SPACESHIP_VI_MODE_INSERT=""
SPACESHIP_VI_MODE_SUFFIX=""

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="$ZDOTDIR/oh-my-custom"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	vi-mode # should be before plugins such as dircycle or it will reset their keybindings
	autojump
	command-not-found
	git
	last-working-dir
	systemd
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh


# ===================================================================
# User configuration
# ===================================================================

# Show hidden files on completion
setopt globdots
# Don't show '..' and '.' on completion
zstyle ':completion:*' special-dirs false

# On ambiguous completion, insert first match immediatly
setopt menu_complete

# Execute lines with history expansion directly
setopt nohist_verify

# Disable autocd
unsetopt auto_cd

# vi-mode: Bring back search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search

# vi-mode: Bring back ctrl+arrow for navigating words
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

# Aliases definitions
. ~/.config/shell/aliases

# fzf
if [[ -d /usr/share/doc/fzf/examples ]]; then
	. /usr/share/doc/fzf/examples/completion.zsh
	. /usr/share/doc/fzf/examples/key-bindings.zsh
fi

# Set colors for ls
eval $(dircolors -b)

# Hub aliasing
if command -v hub > /dev/null; then
	eval "$(hub alias -s)"
fi

# Prompt active tmux sessions
if [[ -z "$TMUX" ]]; then
	tmux_sessions="$(tmux ls 2>/dev/null | wc -l)"
	if [[ "$tmux_sessions" != "0" ]]; then
		printf "Sessões tmux ativas: %s\n" $tmux_sessions
	fi
fi

