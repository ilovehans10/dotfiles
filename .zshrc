export ZSH="${HOME}/.oh-my-zsh"
export LC_ALL="en_US.UTF-8"
source ~/.zplug/init.zsh

# oh-my-zsh configuration
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"

# Variables
export EDITOR="nvim"
export BROWSER="Firefox"
export PATH="$HOME/.scripts:$HOME/.scripts/i3cmds:$HOME/.gem/ruby/2.6.0/bin:$HOME/Documents/RubyMine/bin:$PATH"
export ZDOTDIR="$HOME/.cache/oh-my-zsh"
export LESSHISTFILE=/dev/null

# Aliases
alias vi="nvim"
alias vim="nvim"
alias vimrc="nvim ~/.vimrc"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias lsd="du -d 1 -h"
alias sp="sudo pacman"
alias mkdir="mkdir -pv"
alias ls="ls --color=always -h --group-directories-first"

# Theme
ZSH_THEME="spaceship"

# Plugins
plugins=(
  git
  history-substring-search
  vi-mode
  zsh-autosuggestions
)

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/zsh-vimode-visual", defer:3

zplug load

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/bindings
