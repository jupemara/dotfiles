# Commands Alias
alias "ssh=ssh -A"
alias "csshx=csshx --ssh_args -A --config ~/.ssh/config"

# Add ssh-key
eval $(ssh-agent -s)                               >/dev/null 2>&1
#ssh-add .ssh/IdentityFiles/MY_SSH_PRIVATE_KEY     >/dev/null 2>&1

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

# bash-completion2
if [ -d ${CELLAR} ]; then
    . ${CELLAR}/bash-completion/1.3/etc//bash_completion
fi

# aws-completion
if [ -e ${BREW_HOME}/bin/aws_completer ]; then
    complete -C "$(which aws_completer)" aws
fi

# Use coreutils by brew
if [ -d ${BREW_HOME}/Cellar/coreutils ]; then
    export PATH="${BREW_HOME}/Cellar/coreutils/8.23_1/libexec/gnubin":$PATH
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
fi

# pyenv
if [ -e ${BREW_HOME}/bin/pyenv ]; then
    export PATH="/Users/jumpeiarashi/.pyenv/shims:${PATH}"
    export PYENV_SHELL=bash
    source ${CELLAR}/pyenv/20150204/completions/pyenv.bash
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
