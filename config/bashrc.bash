set completion-ignore-case On

# for load
. ~/.dotfiles/config/util.bash

load  . /etc/bash.bashrc

if [[ -t 1 ]]; then
  bind '"\C-w": unix-filename-rubout'
fi

export LESSOPEN='| /usr/local/bin/src-hilite-lesspipe.sh %s'
export LESS='-gj10 --no-init --quit-if-one-screen --RAW-CONTROL-CHARS'

####    COLORS CONFIGURATION   #####



## LOADING FILES
load /etc/bash_completion

# fzf
load ~/.fzf.bash





DOTFILES_DIR="$HOME/.dotfiles"
CONFIG_DIR="$DOTFILES_DIR/config"

config_files=$(ls $CONFIG_DIR | grep .bash | grep -v util | grep -v bashrc.bash)
for f in $config_files; do
  load ${CONFIG_DIR%/}/$f
done


## EXPORT
export PATH=~/.local/bin:$PATH
export PATH=~/.local/bin/squashfs-root/usr/bin:$PATH
export PATH=$PATH:~/.yarn/bin/create-react-app
export HISTSIZE=10000000        # bash history will save N commands
export HISTFILESIZE=${HISTSIZE} # bash will remember N commands
export PATH=/usr/lib/go-1.11/bin/:$PATH
export PATH=~/bin:$PATH
export GOPATH=$HOME/go
# export GOROOT=/usr/local/go
export PATH=/usr/local/go/bin:$PATH
# export EDITOR="~/.local/bin/squashfs-root/usr/bin/nvim"
export EDITOR="vim"
export PATH="~/go/bin:$PATH"

## MAC
### LINE MAC ORIGINAL mysql5.7
if [ $is_mac = 1 ]; then
  export PATH=$HOME/.nodebrew/current/bin:$PATH
  export PATH=/usr/local/opt/mysql@5.7/bin:$PATH
fi

# JAVA
if [[ -e /usr/libexec/java_home ]] && [[ $is_mac = 1 ]]; then
  export JAVA_HOME=$(/usr/libexec/java_home -v 1.8)
fi

export PATH=$JAVA_HOME/bin:$PATH
export PATH=/opt/gradle/bin:$PATH
# rust
export PATH=$HOME/.cargo/bin:$PATH
# golang
export PATH=~/go/bin/:$PATH

# FZF and FD
# https://wonderwall.hatenablog.com/entry/2019/03/06/224000
# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --color=always'
export FZF_DEFAULT_COMMAND='fd --type file --color=always'
export FZF_DEFAULT_OPTS=' --ansi '
export PATH="/usr/local/n/versions/node/12.14.0/bin/:$PATH"

# JDK 11 have to use
# jEnv
export JENV_ROOT="$HOME/.jenv"
if [ -d "${JENV_ROOT}" ]; then
  export PATH="$JENV_ROOT/bin:$PATH"
  eval "$(jenv init -)"
fi
## go
export GO111MODULE=on
export GOOS_GOARCH=linux_amd64
# export GOOS=linux
# export GOARCH=amd_64

# eval "$(direnv hook bash)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


export PATH=$PATH:~/.local/bin
export SSLKEYLOGFILE=/tmp/.ssl-key.log
