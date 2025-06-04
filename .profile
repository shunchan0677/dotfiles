export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"


if [ -t 1 ] && [ -z "$ZSH_OVERRIDE" ]; then
    export ZSH_OVERRIDE=1
    exec /usr/bin/zsh -l
fi
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"

. "$HOME/.local/bin/env"
