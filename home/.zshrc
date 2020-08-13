# Path to your oh-my-zsh configuration.
ZSH=$HOME/.zsh/oh-my-zsh
ZSH_CUSTOM=$HOME/.zsh/oh-my-zsh-customizations

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.

ZSH_THEME="powerlevel10k/powerlevel10k"
POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time)
kubeon() { POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(kubecontext status time) }
kubeoff() { POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status time) }

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

all_platform_plugins=(docker gitfast last-working-dir mosh vagrant kubectl)

if [ -z "$SSH_AUTH_SOCK" ]; then
  all_platform_plugins=($all_platform_plugins ssh-agent)
fi
plugins=($all_platform_plugins)

source $ZSH/oh-my-zsh.sh
source ~/.zsh/jump.plugin.zsh

# Customize to your needs...

# vi-mode: ctrl-r starts searching history backward
bindkey '^r' history-incremental-search-backward
bindkey "\e[3~" delete-char
bindkey "\e$terminfo[kcub1]" backward-word
bindkey "\e$terminfo[kcuf1]" forward-word

export EDITOR=vim
export LANGUAGE=en_US
export TERM=xterm-256color
export TNS_ADMIN=/etc # set oracle home


# ssh without memory
alias ssh_anon="ssh -o \"UserKnownHostsFile /dev/null\""
alias scp_anon="scp -o \"UserKnownHostsFile /dev/null\""
alias sftp_anon="sftp -o \"UserKnownHostsFile /dev/null\""
alias ssh-copy-id_anon="ssh-copy-id -o \"UserKnownHostsFile /dev/null\""

alias iosc="osc -A https://api.suse.de"
alias mosc="osc -A https://api.pub.meego.com"

alias json_pretty_print="python -mjson.tool"

alias en_us_intl="setxkbmap -layout en -variant intl"

alias docker-compose-overlay="docker-compose --x-networking --x-network-driver overlay"

################
# TMUX section #
################

# start tmux forcing 256 color mode (the setting inside of .tmux.conf is ignored)
[ -n "$TMUX" ] && export TERM=screen-256color-bce

# This loads openstack env variables.
[[ -s "$HOME/.openstack/novarc" ]] && source "$HOME/.openstack/novarc"

# fix home/end keys inside of gnome-terminal and xfce4/terminal
bindkey "^[OH" beginning-of-line
bindkey "^[OF" end-of-line

export PATH="$HOME/.rbenv/bin:$HOME/go/bin:$HOME/bin:/usr/local/kubebuilder/bin:$PATH"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
eval "$(rbenv init -)"

#export VAGRANT_DEFAULT_PROVIDER="libvirt"

# Refresh gpg-agent tty in case user switches into an X session
gpg-connect-agent updatestartuptty /bye >/dev/null

# direnv
#eval "$(direnv hook zsh)"

# fzf
source /etc/zsh_completion.d/fzf-key-bindings

# required to get operator-sdk to work when upstream release binaries are used
export GOROOT=$(go env GOROOT)

# hub cli
eval "$(hub alias -s)"

# https://github.com/kubernetes/kubernetes/issues/46381#issuecomment-461404505
function kmerge() {
  KUBECONFIG=~/.kube/config:$1 kubectl config view --flatten > ~/.kube/mergedkub && mv ~/.kube/mergedkub ~/.kube/config
}
