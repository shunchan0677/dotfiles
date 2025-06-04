########################
#    basic settings    #
########################
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=1000000
setopt HIST_IGNORE_DUPS     # do not recode deprecated cmd
setopt HIST_IGNORE_ALL_DUPS # do not recode deprecated cmd
setopt HIST_IGNORE_SPACE    # do not record cmd whose start char is space
setopt HIST_FIND_NO_DUPS    # reduce deprecated cmd when finding
setopt HIST_REDUCE_BLANKS   # remove blank
setopt HIST_NO_STORE        # do not record history cmd
setopt share_history        # share history among the tmux panes and windows
unsetopt auto_remove_slash

#########################
#      Zplug init       #
#########################
source ~/.zplug/init.zsh

#########################
#     Zplug plugins     #
#########################
autoload colors && colors
setopt prompt_subst

# manage zplug by zplug
zplug 'zplug/zplug', hook-build:'zplug --self-manage'
# make command completion stronger
zplug "zsh-users/zsh-completions"
# make command auto suggestion based on history
zplug "zsh-users/zsh-autosuggestions"
# command line syntax highlight
zplug "zsh-users/zsh-syntax-highlighting", defer:2
# load theme from local
zplug "~/.zsh/themes/", from:local, use:bullet-train.zsh-theme, defer:3


# install check and then load
zplug check || zplug install
zplug load

bindkey '^]' autosuggest-accept

#########################
#      fzf settings     #
#########################
export FZF_DEFAULT_OPTS='
    --reverse
    --exit-0 --select-1
    --color fg:-1,bg:-1,hl:230,fg+:3,bg+:233,hl+:229
    --color info:150,prompt:110,spinner:150,pointer:167,marker:174'
export FZF_CTRL_R_OPTS="
    --sort
    --preview 'echo {}'
    --preview-window down:10:hidden:wrap
    --bind '?:toggle-preview'"
export FZF_CTRL_T_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'bat -n --color=always {}'
  --bind '?:change-preview-window(down|hidden|)'"
export FZF_DEFAULT_COMMAND="fd -d 2 --no-ignore-vcs --ignore-file ~/.ignore --hidden --follow"
export FZF_TMUX=1
export FZF_TMUX_OPTS="-p 85%"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# not to use ctrl + T and alt + C
bindkey -r "^T"
bindkey -r "\ec"
bindkey '^F' fzf-file-widget

#########################
#  completion settings  #
#########################
# enable completion
zmodload -i zsh/complist
autoload -Uz compinit && compinit

# colorized path completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' verbose no
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

# vim like movement when completion
zstyle ':completion:*:default' menu select=2
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char

# completion from intermediate
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

###################################
#            Others               #
###################################
alias la="ls -a"
alias ll="ls -l"
alias lla="ls -la"
alias squeue='squeue -h -o "%.9i %.5P %.35j %.10u %.1t %.11M %.9R cpu:%.2C %.20b"'

# SSH forward agent
[[ $SSH_AUTH_SOCK != $HOME/.ssh/sock && -S $SSH_AUTH_SOCK ]] \
    && ln -snf "$SSH_AUTH_SOCK" "$HOME/.ssh/sock" \
    && export SSH_AUTH_SOCK="$HOME/.ssh/sock"

# activate pyenv
eval "$(pyenv init -)"

export PATH=$HOME/.local/bin:$PATH
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

. "$HOME/.local/bin/env"
