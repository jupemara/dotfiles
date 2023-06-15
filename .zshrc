# Language specification
export LANG=C

# prompt
PROMPT="%DT%* %m:%c $ "

# load special environment variables

if [ -f ${HOME}/.env ]; then
  . ${HOME}/.env
fi

# Commands Alias
alias "ssh=ssh -A"

# launch ssh-agent
ssh_agent_alias="${HOME}/.ssh/agent"
if [ -S "${SSH_AUTH_SOCK}" ]; then
  case ${SSH_AUTH_SOCK} in
    /var/*/agent.[0-9]*)
      ln -snf "${SSH_AUTH_SOCK}" $ssh_agent_alias && export SSH_AUTH_SOCK=$ssh_agent_alias
    ;;
    /private/*/Listeners)
      eval $(ssh-agent -s)                      >/dev/null 2>&1
      ssh-add ${HOME}/.ssh/key/id_rsa >/dev/null 2>&1
    ;;
  esac
elif [ -S "${ssh_agent_alias}" ]; then
  export SSH_AUTH_SOCK=$ssh_agent_alias
fi

# history
export HISTSIZE=100000
export HISTIGNORE='history:fg*:bg*:pwd'

# brew
if [ -e /opt/homebrew/bin ]; then
  export PATH="/opt/homebrew/bin:$PATH"
  export PATH="/opt/homebrew/sbin:$PATH"
  eval "$(brew shellenv)"
fi
BREW_HOME=$(brew --prefix)

# enable zsh completions
autoload -Uz compinit
compinit

# aws-completion
if [ -e ${BREW_HOME}/awscli ]; then
  . ${BREW_HOME}/awscli/share/zsh/site-functions/aws_zsh_completer.sh
fi

# Use coreutils by brew
if [ -e $(brew --prefix coreutils) ]; then
  export PATH="$(brew --prefix coreutils)/libexec/gnubin":$PATH
fi

# kubectl
if [ -e $(brew --prefix kubectl) ]; then
  . <(kubectl completion zsh)
fi

# graphviz
if [ -e $(brew --prefix graphviz) ]; then
  GRAPHVIZ_DOT=$(which dot)
fi


# anyenv
if [ -e ${BREW_HOME}/bin/anyenv ]; then
  eval "$(${BREW_HOME}/bin/anyenv init -)"
  export PATH="$HOME/.anyenv/bin:$PATH"
fi

# gcloud
if [ -e "${BREW_HOME}/Caskroom/google-cloud-sdk" ]; then
  prefix="${BREW_HOME}/Caskroom/google-cloud-sdk/latest/google-cloud-sdk"
  export PATH="${prefix}/bin":$PATH
  source ${prefix}/completion.zsh.inc
fi

# asdf
if [ -e $(brew --prefix asdf) ]; then
  . $(brew --prefix asdf)/libexec/asdf.sh
  . $(brew --prefix asdf)/etc/bash_completion.d/asdf.bash
  export ASDF_DIR=$(brew --prefix asdf)/libexec
  . ${ASDF_DIR}/asdf.sh
fi

# golang
if [ -e $(brew --prefix asdf) ] && [ -e $(asdf where golang) ]; then
  export GOROOT="$(asdf where golang)/go"
  export GOPATH="${HOME}/go/$(asdf current golang | awk '{print $2}')"
fi

# android studio
if [ -e "${BREW_HOME}/Caskroom/android-studio" ]; then
  export ANDROID_SDK_ROOT=${HOME}/Library/Android/sdk
fi

# java home
if [ -e $(brew --prefix java) ]; then
  export JAVA_HOME=$(brew --prefix java)
fi

# dot-net-core
# if [ -e $(brew --prefix asdf) ] && [ -e ${HOME}/.asdf/plugins/dotnet-core ]; then
#   . ${HOME}/.asdf/plugins/dotnet-core/set-dotnet-home.zsh
# fi

# Commands Alias in brew
alias "ls=ls --color=auto"
alias "ll=ls -lA --color=auto"
alias "gb=git branch"
alias "gco=git checkout -b"
alias "gs.=git status ."
alias "gd=git diff"
alias "ga=git add"
alias "gp=git push"
alias "gcm=git commit"
