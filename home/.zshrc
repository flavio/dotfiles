# Path to your oh-my-zsh configuration.
ZSH=$HOME/.zsh/oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="jreese"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)

# Load solarized dircolors
eval `dircolors ~/.zsh/dircolors-solarized/dircolors.256dark`

all_platform_plugins=(docker gem git golang ruby rails3)

if [ -z "$SSH_AUTH_SOCK" ]; then
  all_platform_plugins=($all_platform_plugins ssh-agent)
fi

plugins=($all_platform_plugins $os_plugins)

source $ZSH/oh-my-zsh.sh
source ~/.zsh/jump.plugin.zsh

# Customize to your needs...
export EDITOR=vim
export LANGUAGE=en_US
export TERM=xterm-256color
export TNS_ADMIN=/etc # set oracle home


# ssh without memory
alias ssh_anon="ssh -o \"UserKnownHostsFile /dev/null\""
alias scp_anon="scp -o \"UserKnownHostsFile /dev/null\""
alias sftp_anon="sftp -o \"UserKnownHostsFile /dev/null\""

alias iosc="osc -A https://api.suse.de"
alias mosc="osc -A https://api.pub.meego.com"

alias json_pretty_print="python -mjson.tool"

# needed to have flash audio working with SLED11
export FLASH_FORCE_ALSA=1

################
# TMUX section #
################

# start tmux forcing 256 color mode (the setting inside of .tmux.conf is ignored)
[ -n "$TMUX" ] && export TERM=screen-256color-bce

if which tmux 2>&1 >/dev/null; then
  #if not inside a tmux session, and if no session is started, start a new session
  test -z "$TMUX" && [[ $HOSTNAME != 'rush.in.da.house' ]] && [[ $HOSTNAME != 'roesti.in.da.house' ]] && (tmux attach || tmux new-session)
fi

# This loads openstack env variables.
[[ -s "$HOME/.openstack/novarc" ]] && source "$HOME/.openstack/novarc"

# fix home/end keys inside of gnome-terminal and xfce4/terminal
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line

# force jruby to use 1.9 mode
export JRUBY_OPTS="--1.9"

# force rubinius to use 1.9 mode
export RBXOPT='-X19'

export PATH=/home/flavio/go/bin:$PATH