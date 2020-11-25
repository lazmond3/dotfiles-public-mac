function myawk() {
    awk "{print \$$1 }"
}

function mytest() {
  test $@
  echo result: $?
}

function get_len() {
  echo length: ${#1}
}

# python os.path.join
function opj() {
  echo ${1%/}/$2
}

is_debug=0
function set_debug() {
  is_debug=$1
}

function debug_log() {
  if [ $is_debug = 1 ]; then
    echo "$@"
  fi
}

function load() {
  if [ -e "$*" ]; then
    if [ -d $1 ]; then
      bash_files=$(ls $1 | grep .bash)
      for f in $bash_files; do 
        debug_log "[load] ${1%/}/$f"
        source "${1%/}/$f"
      done
    else
      source $(echo "$*")
      debug_log "[load] $*"
    fi
  else
    debug_log "[load]" [failed] to load $@
  fi
}

function awk2() {
  awk "{print \$$1}"
}

function mymkdir() {
    if [ ! -d $1 ]; then
        mkdir -p $1
    else
        debug_log already exist dir.
    fi
}

function delete_if() {
  if [ -f $1 ]; then
    debug_log delete $1
    rm $1;
  fi
}

###
#OS分岐

is_mac=0
is_apt=0
is_yum=0

function check_os(){
    if [ $(which brew) ]; then
        is_mac=1
    elif [ $(which yum) ]; then
        is_yum=1
    elif [ $(which apt) ]; then
        is_apt=1
    else
        echo no such os
    fi
}

check_os
