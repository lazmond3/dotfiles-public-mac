alias vlist="vb list"
alias vselect="vb list | fzf"
function vstop() {
  VBoxManage controlvm $(vselect) poweroff
}

## CURL
alias cpost="curl -X POST -H \"Content-Type:application/json\"  "
## PYTHON VENV
alias vv="source venv/bin/activate"
alias vvo="deactivate"
alias vvv="virtualenv -p python3.7 venv"
## YOUTUBE
alias ll="ls -rtl "
alias yaa="youtube-dl --extract-audio --audio-format mp3 --output \"%(uploader)s%(title)s.%(ext)s\"  "
alias ykk="youtube-dl  -o  \"%(uploader)s-%(alt_title)s.%(ext)s\""
alias mp3="youtube-dl --extract-audio --audio-format \"mp3\" "
alias dl="youtube-dl "

## MySQL
alias mysql="mysql  --protocol=tcp"

## MAC
alias bi="brew install "
mysql_beta_param="--protocol=tcp -uwww_read -h10.127.33.10 -P20306 -pwwwwww linecast_beta"
mysql_beta_param_dump="--single-transaction $mysql_beta_param"
alias mylocal="mysql --protocol=tcp -uroot -Dlinecast_local "
alias mylocaldump="mysqldump --protocol=tcp -uroot linecast_local "
alias mybeta="mysql $mysql_beta_param"
# alias mybetadump="mysqldump  --single-transaction $mysql_beta_param"
function mybetadumpf() {
  echo "table: $1"
  mysqldump $mysql_beta_param_dump "$@" | mylocal -Dlinecast_local
}
# alias mmimp="for u in $(ls); do echo $u; [[ ! -d $u ]] && mimp < $u; done"

# Mac 

if [ $is_mac = 1 ]; then
  alias pb="pbcopy"
fi

# WSL
alias ex="explorer.exe ."
alias cm="cmake.exe .. -A x64"

## DOCKER
alias dp="docker ps"

## YARN
alias ya="yarn add "
alias y="yarn"
alias ys="yarn start"
# alias yd="yarn deploy"
alias dib="cp ~/.dotfiles/config/.bashrc ~"

# convenient
alias tailf="tail -F "
alias ggg="vi ~/.dotfiles/initbash/golang.bash"
alias fff="vi ~/.bashrc_functions"
alias sss="vi ~/.ssh/config"
alias aaa="vi ~/.ssh/authorized_keys"
alias kkk="vi ~/.ssh/known_hosts"
alias ttt="vi ~/.tmux.conf"
alias duf="du --max-depth=1  -h | sort -h | tee DUFLOG"
alias df="df -h"
alias sc="source ~/.bashrc"
alias xs="tr -d '\n' | xsel --clipboard --input"
alias xx=" xsel --clipboard --input "
alias l=ls
alias ll='ls -rhtl'
alias ki="kill %"
alias cdp='cd $(pwd -P)'
alias less="less -R "
# alias ddd='vi ~/.config/nvim/init.vim'
alias ddd='vi ~/.vimrc'
alias ccc="(cd ~/.dotifles; vi ./config/bashrc.bash)"
# alias ccc="vi ~/.bashrc"

# sub-convenient
alias na='nautilus .'
alias ssh="ssh -Y"
alias sudo="sudo -E "
alias pwd='pwd -P'
# alias vi="nvim"
alias vi="vim"
alias ls="ls -G"
alias ll="ls -G -rtl"
alias gss="git status "

## APT
alias ai="sudo apt install -y "
alias au="sudo apt update -y "
alias as="apt search "

alias disp="echo $DISPLAY"

## GIT
alias gdh="git diff HEAD^ HEAD"
alias gck="git checkout "
alias gch="git checkout "
alias gcb="git checkout -b "
alias gst="git stash save"
alias gsp="git stash pop"
alias ga="git add "
alias gd="git diff "
alias gdc="git diff --cached"
alias gb="git branch "
alias gl="git log "
alias glo="git log --oneline"
alias gc="git commit  "
# alias lc="git commit -m "
alias gro="git remote add origin "
alias gro2="git remote add origin2 "
alias gorm="git remote rm origin"
alias gorm2="git remote rm origin2"
alias groshow="git remote show origin"
alias groshow2="git remote show origin2"

## SYSTEMCTL
alias status="sudo systemctl status "
alias restart="sudo systemctl restart "
alias stop="sudo systemctl stop "
alias enable="sudo systemctl enable  "

## UTIL
alias killf="kill \$(ps aux | fzf -m | awk '{print \$2}')"
alias sth="stty erase ^H"
alias sty="stty erase '^?'"

alias tree='tree -a -I "\.DS_Store|\.git|node_modules|.cache|dist|yarn.lock|.gitignore|vendor\/bundle" -N'