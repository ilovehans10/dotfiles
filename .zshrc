export ZSH="${HOME}/.config/.oh-my-zsh"
source "${HOME}/.iterm2_shell_integration.zsh"
export LC_ALL="en_US.UTF-8"
source ~/.zplug/init.zsh

# oh-my-zsh configuration
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"

# Variables
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

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/bindings

build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_virtualenv
  prompt_aws
  prompt_dir
  prompt_git
  prompt_bzr
  prompt_hg
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
