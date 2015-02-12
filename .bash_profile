# Commands Alias
alias "ls=ls --color=auto"
alias "ll=ls -lA --color=auto"
alias "ssh=ssh -A"
alias "csshx=csshx --ssh_args -A --config ~/.ssh/config"
alias "vmstart=VBoxManage startvm --type headless"

# Add ssh-key
eval $(ssh-agent -s)                               >/dev/null 2>&1
#ssh-add .ssh/IdentityFiles/MY_SSH_PRIVATE_KEY     >/dev/null 2>&1

# bash history
export HISTSIZE=100000
export HISTIGNORE='history:fg*:bg*:pwd'

# set cabal's path
if [ -e ${HOME}/.cabal/bin ]; then
    PATH=${HOME}/.cabal/bin:$PATH
fi

# set boxen's path
if [ -e /opt/boxen ]; then
    BOXEN_HOME="/opt/boxen"
    . "$BOXEN_HOME/env.sh"
fi

# set brew's home
if [ -e ${BOXEN_HOME}/homebrew ]; then
    BREW_HOME="${BOXEN_HOME}/homebrew"
fi

# bash-completion2 
if [ -e ${BREW_HOME}/bin/brew ]; then
    . $(${BREW_HOME}/bin/brew --prefix)/share/bash-completion/bash_completion
fi

# aws-completion
if [ -e ${BREW_HOME}/bin/aws_completer ]; then
    complete -C "$(which aws_completer)" aws
fi

# Use coreutils by brew
if [ -d ${BREW_HOME}/Cellar/coreutils ]; then
    PATH="${BREW_HOME}/Cellar/coreutils/8.23/libexec/gnubin":$PATH
fi
export PATH

# python virtualenvwrapper
if [ -e ${BREW_HOME}/bin/virtualenvwrapper_lazy.sh ]; then
    . ${BREW_HOME}/bin/virtualenvwrapper_lazy.sh
elif [ -e /usr/bin/virtualenvwrapper_lazy.sh ]; then
    . /usr/bin/virtualenvwrapper_lazy.sh
fi

# init nvm
if [ -e $(brew --prefix nvm)/nvm.sh ]; then
    . $(brew --prefix nvm)/nvm.sh
fi

# pyenv
if [ -e ${BREW_HOME}/bin/pyenv ]; then
    export PATH="/Users/jumpeiarashi/.pyenv/shims:${PATH}"
    export PYENV_SHELL=bash
    source '/opt/boxen/homebrew/Cellar/pyenv/20141008/libexec/../completions/pyenv.bash'
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

# read .bashrc
if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
