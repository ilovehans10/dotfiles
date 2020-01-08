local OS=$(uname -s)
case $OS in
  Darwin) export ZSH="${HOME}/.config/.oh-my-zsh"
          source "${HOME}/.iterm2_shell_integration.zsh";;
  Linux)  export ZSH="${HOME}/.oh-my-zsh";;
esac
export LC_ALL="en_US.UTF-8"
source ~/.zplug/init.zsh

# oh-my-zsh configuration
HYPHEN_INSENSITIVE="true"
DISABLE_UPDATE_PROMPT="true"
ENABLE_CORRECTION="true"

# Variables
export EDITOR="nvim"
export BROWSER="Firefox"
case $OS in
  Darwin) export PATH="$HOME/.gem/ruby/2.6.0/bin:$HOME/Documents/RubyMine/bin:/usr/local/sbin:$PATH";;
  Linux)  export PATH="$HOME/.gem/ruby/2.6.0/bin:$HOME/Documents/RubyMine/bin:$HOME/.scripts:$HOME/.scripts/i3cmds:$PATH";;
esac
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
case $OS in
  Darwin) ZSH_THEME="agnoster";;
  Linux) ZSH_THEME="spaceship";;
esac

# Plugins
plugins=(
  git
  taskwarrior
  vi-mode
  zsh-autosuggestions
  history-substring-search
)

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/zsh-vimode-visual", defer:3

zplug load

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh
source ~/.config/zsh/bindings

if [[ $OS = Darwin ]]; then
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
fi
