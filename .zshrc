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
  Darwin) export PATH="/usr/local/Cellar/ruby/2.7.0/bin:/usr/local/lib/ruby/gems/2.7.0/gems:$HOME/Documents/RubyMine/bin:$HOME/go/bin:/usr/local/sbin:/usr/local/lib/ruby/gems/2.6.0/bin:$PATH";;
  Linux)  export PATH="/usr/local/lib/ruby/gems/2.6.0/gems:$HOME/Documents/RubyMine/bin:$HOME/go/bin:$HOME/.scripts:$HOME/.scripts/i3cmds:$PATH";;
esac
export ZDOTDIR="$HOME/.cache/oh-my-zsh"
export LESSHISTFILE=/dev/null

# Theme
if [[ $OS = Darwin ]]; then
   ZSH_THEME="agnoster"
fi

# Plugins
plugins=(
  git
  taskwarrior
  vi-mode
  zsh-autosuggestions
  history-substring-search
)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

zplug "zsh-users/zsh-syntax-highlighting", defer:2
zplug "b4b4r07/zsh-vimode-visual", defer:3
zplug "denysdovhan/spaceship-prompt", use:spaceship.zsh, from:github, as:theme

zplug load

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

# Aliases
alias vi="nvim"
alias vim="nvim"
alias vimrc="nvim ~/.vimrc"
alias zshrc="nvim ~/.zshrc"

alias config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias rangerr="ranger --choosedir=/tmp/.rangerdir; LASTDIR=\`cat /tmp/.rangerdir\`; cd '$LASTDIR'"
alias yey="yes | yay"
alias sss="sudo systemctl suspend"
alias lg="lazygit"

alias lsd="du -d 1 -h"
alias ls="ls --color=always -h --group-directories-first"
alias sp="sudo pacman"
alias mkdir="mkdir -pv"
