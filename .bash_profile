# Commands Alias
alias "ssh=ssh -A"
alias "csshx=csshx --ssh_args -A --config ~/.ssh/config"

# Add ssh-key
eval $(ssh-agent -s)                               >/dev/null 2>&1
ssh-add ${HOME}/.ssh/IdentityFiles/id_rsa      >/dev/null 2>&1

# bash history
export HISTSIZE=100000
export HISTIGNORE='history:fg*:bg*:pwd'

# set cabal's path
if [ -e ${HOME}/.cabal/bin ]; then
    export PATH=${HOME}/.cabal/bin:$PATH
fi

# set BREW_HOME
BREW_HOME=$(brew --prefix)
CELLAR=$(brew --cellar)

# bash-completion
if [ -e $(brew --prefix bash-completion) ]; then
    . "$(brew --prefix bash-completion)/etc/bash_completion"
fi

# aws-completion
if [ -e ${BREW_HOME}/bin/aws_completer ]; then
    complete -C "$(which aws_completer)" aws
fi

# Use coreutils by brew
if [ -e $(brew --prefix coreutils) ]; then
    export PATH="$(brew --prefix coreutils)/libexec/gnubin":$PATH
fi

# python virtualenvwrapper
if [ -e ${BREW_HOME}/bin/virtualenvwrapper_lazy.sh ]; then
    . ${BREW_HOME}/bin/virtualenvwrapper_lazy.sh
elif [ -e /usr/bin/virtualenvwrapper_lazy.sh ]; then
    . /usr/bin/virtualenvwrapper_lazy.sh
fi

# init nvm
if [ -e $(brew --prefix nvm)/nvm.sh ]; then
    . $(brew --prefix nvm)/nvm.sh
    export NVM_DIR=~/.nvm
    nvm use v6
fi

# initialize rbenv
if [ -e $(brew --prefix rbenv) ]; then
    export RBENV_ROOT=$(brew --prefix rbenv)
    eval "$(rbenv init -)"
fi

# pyenv
if [ -e ${BREW_HOME}/bin/pyenv ]; then
    export PATH="/Users/jumpeiarashi/.pyenv/shims:${PATH}"
    export PYENV_SHELL=bash
    source ${CELLAR}/pyenv/20160202/completions/pyenv.bash
    pyenv rehash 2>/dev/null
    pyenv() {
        local command
        command="$1"
          if [ "$#" -gt 0 ]; then
              shift
          fi

        case "$command" in
        activate|deactivate|rehash|shell)
            eval "`pyenv "sh-$command" "$@"`";;
        *)
            command pyenv "$command" "$@";;
        esac
    }
fi

# Commands Alias in brew
alias "ls=ls --color=auto"
alias "ll=ls -lA --color=auto"

# read .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
