export ZSH="${HOME}/.config/.oh-my-zsh"
source "${HOME}/.iterm2_shell_integration.zsh"
source ~/.zplug/init.zsh

HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"

export EDITOR="nvim"
export BROWSER="Firefox"
export PATH="$HOME/.gem/ruby/2.6.0:$HOME/Documents/RubyMine/bin:$PATH"
export ZDOTDIR="$HOME/.cache/oh-my-zsh"
export LESSHISTFILE=/dev/null

# Aliases
alias vi="nvim"
alias vim="nvim"
alias vimrc="nvim ~/.vimrc"
alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias lsd="du -d 1 -h"

# Theme
ZSH_THEME="agnoster"

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

source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/bindings
