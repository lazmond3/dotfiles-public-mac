
###########################
## UTILITY
###########################
# TODO: 使ってない関数が多い


function pyinit() {
  for u in $@; do
    mkdir $u
    touch $u/__init__.py
  done
}

function pyfiles() {
  for u in $@; do
    touch $u.py
  done
}

function wsl_check() { if [[ -d /mnt/c ]]; then echo 1; else echo 0; fi; }
function mac_check() { if [[ -d /Users ]]; then echo 1; else echo 0; fi; }
is_wsl=$(wsl_check)
is_mac=$(mac_check)

function pg() { ps aux | grep $1 | grep -v grep; }
function is_in_git_repo() { git rev-parse HEAD >/dev/null 2>&1; }
function inf() {
  while :; do
    bash -c "$*"
    sleep 0.2
  done
}

function ggrep() { grep $1 | grep $2; }

###########################
## multi delete
###########################
function _move_to_trash() {
  if [[ -d ~/.gomi ]]; then
    :
  else
    mkdir ~/.gomi
  fi
  mv "$1" ~/.gomi/
}

function muldelete() {
  local files
  files=$(ls -lt) &&
    files=$(echo "${files}" | sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" | fzf --multi) &&
    echo -e "$files" | while read line; do # or use AWK
      if [[ $is_mac = 1 ]]; then
        line=$(echo "$line" | myawk 9)
      else
        line=$(echo "$line" | myawk 8) # IN WSL, Linux
      fi

      echo delete to .gomi: $line &&
      _move_to_trash "${line//@/}"
    done
}

# fdr - cd to selected parent directory
function fdr() { # not work
  local declare dirs=()
  function get_parent_dirs() {
    if [[ -d "${1}" ]]; then dirs+=("$1"); else return; fi
    if [[ "${1}" == '/' ]]; then
      for _dir in "${dirs[@]}"; do echo $_dir; done
    else
      get_parent_dirs $(dirname "$1")
    fi
  }
  local DIR=$(get_parent_dirs $(pwd -P) | fzf-tmux)
  cd "$DIR"
}

# worktree移動
# TODO: UNUSED
function cdworktree() {
  # カレントディレクトリがGitリポジトリ上かどうか
  git rev-parse &>/dev/null
  if [ $? -ne 0 ]; then
    echo fatal: Not a git repository.
    return
  fi

  local selectedWorkTreeDir=$(git worktree list | fzf | myawk 1)

  if [ "$selectedWorkTreeDir" = "" ]; then
    # Ctrl-C.
    return
  fi

  cd ${selectedWorkTreeDir}
}

###########################
##  GIT 関係
###########################
function cmt() {
  git log --color=always --oneline | fzf --ansi --reverse -m | myawk 1
}


# _after_t query [number] queryを発見した後, number行を捨てるという意味だった気がする。
function _after_t() {
  query="$1"
  number=$2
  number=$((number + 1))
  start=false

  while read line; do
    if [[ "$line" =~ "$query" ]] && [ $start = false ]; then
      start=true
    elif [ $start = false ]; then continue; fi

    if [ $number = 0 ]; then
      if [[ "$line" = "" ]]; then
        return
      fi

      if [[ "$line" =~ "no change" ]]; then
        return
      fi

      echo "$line"
    else
      number=$((number - 1))
    fi
  done
}

# httpsで登録してしまったものをgitに直す。
function gitrep() {
  origin=$(groshow |
    ggrep Fetch https | awk '{print $3}' | sed -e "s@https://github.com/\([a-zA-Z0-9_]\+\)/\([a-zA-Z0-9_]\+\)\(.git\)\?@git\@github.com:\1\/\2.git@g")
  echo origin : $origin
  gorm #削除
  gro "$origin"
}

# git raw get
function rget() {
  url=$1
  newUrl=$(echo $1 | sed -e "s/github\.com/raw.githubusercontent.com/g" -e "s/blob\///g")
  wget $newUrl
}


###########################
##  SSH
###########################
## SSH local MAPPING
function L() {
  if [ $# = 2 ]; then
    ssh -L $2:localhost:$2 $1 -N -f
    return
  else
    echo "L <HOST> <PORT>"
  fi
}

function LL() {
  if [ $# = 3 ]; then
    ssh -L $2:localhost:$3 $1 -N -f
    return
  else
    echo "L <HOST> <LOCAL PORT> <REMOTE PORT>"
  fi
}


###########################
##  ファイルコピー・転送
###########################
function msyn() {
  if [[ $# = 2 ]] || [[ $# -gt 2 ]]; then
    first=$1
    secon=$2
    if [ "${first: -1}" = "/" ]; then
      first=${first%/}
    fi

    if [[ ! -d "$secon" ]]; then # まだディレクトリとしてない場合
      first="${first}/"          # / をつけると、そのまま展開
    fi

    if [[ $# = 2 ]]; then
      shift
      shift
      echo /usr/bin/rsync -r "$first" "$secon"
      /usr/bin/rsync -r "$first" "$secon"
    else
      shift
      shift
      OPT=""
      for n in "$@"; do
        OPT="$OPT --exclude=$n "
      done
      echo /usr/bin/rsync -r "$first" "$secon" $OPT
      /usr/bin/rsync -r "$first" "$secon" $OPT
    fi

  else
    echo "rc <from> <dest> <exclude>"
  fi
}

function upsakura() {
  if [ $# = 2 ]; then
    scp -r "$1" sakura:~/static/"$2"
  else
    scp -r "$1" sakura:~/static/"$1"
  fi
}

# TODO: ファイル名から最後のスラッシュをあれば削除、という関数を作ってそれを利用したい。
function up() {
  ssh nova "rm -rf ~/static/$1"
  if [ $# = 2 ]; then
    scp -r "$1" nova:~/static/"$2"
  else
    scp -r "$1" nova:~/static/"$1"
  fi
}

function down() {
  rm -rf "$1"
  scp -r nova:~/static/"$1" "$1"
}

###########################
##  yarn
###########################
function ya() {
  yarn add "$@"
  typesync
  yarn
}

###########################
## FZF DIRECTORY DIG
###########################
function fdig() {
  while :; do
    out="$(ll | grep ^d | sed '1i\
      _ _ _ _ _ _ _ _  back\
      ' | fzf --height 20 --preview 'ls | grep -v ^d ' | awk '{print $9}')"

    if [[ "$out" == "" ]]; then
      break
    elif [[ "$out" == "back" ]]; then cd ..; fi

    cd "$out"
    test $? -gt 128 && break
  done
}



###########################
## DUMP TO LOCAL
###########################
function mylocaldump() {
  if [[ $# != 1 ]]; then
    echo Usage: mylocaldump "<tablename>"
    exit 1
  fi
  local tname=$1
  local LOCAL_MYSQL_OPT="--protocol=tcp -uroot"
  local BETA_MYSQL_OPT="--protocol=tcp -uwww_read -h10.127.33.10 -P20306 -pwwwwww linecast_beta "
  local DUMP_BETA_MYSQL_OPT="--single-transaction $BETA_MYSQL_OPT"

  echo $tname
  mysqldump --verbose $DUMP_BETA_MYSQL_OPT "$tname" | mysql $LOCAL_MYSQL_OPT -Dlinecast_local
}


function sinit() {
  L nova 8091
  L nova 8089
  ssh nova -f -N -D 1080
}

function skip_lines() {
  tail -n +$(($1 + 1))
}