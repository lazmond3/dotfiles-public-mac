###########################
## cd history fzf ## ここでトグルしたい！
###########################

function cd() {
  # if [[ $# -ge 2 ]]; then [[ "$1" == "--" ]] && shift; fi
  # if [[ $# == 0 ]]; then
  #   builtin cd
  #   return
  # fi
  # local absPath=$(builtin cd "$*" && pwd -P)
  # absPath=$(echo "$absPath" | sed -n 1P)
  # # echo absPath: $absPath

  # if [ "${_ht_dirs["$absPath"]}" ]; then
  #   _ht_dirs["$absPath"]=$((_ht_dirs["$absPath"] + 1))
  # else
  #   _ht_dirs["$absPath"]=1
  # fi

  builtin cd $@
  ls
}

function cdkeys() {
  for key in "${!_ht_dirs[@]}"; do
    echo $key : value: ${_ht_dirs[$key]}
  done
}

###########################
## INITIAL DIR
###########################
function dirinit() {
  local dirs=$(for AREA in "${!_ht_dirs[@]}"; do printf "%s\n" "${AREA}"; done | fzf -m)
  if [[ "$dirs" == "" ]]; then
    return
  fi
  for AREA in "$dirs"; do
    echo "$AREA" >>~/.default_dirs
  done
}

function diradd() {
  echo add $(pwd) to defaultdirs!
  echo $(pwd) >> ~/.default_dirs
}

if [[ -e ~/.default_dirs ]]; then
  for AREA in $(cat ~/.default_dirs); do
    _ht_dirs["$AREA"]=100
  done
fi

function _seeDirs() {
  local paths pathNum path
  paths=$(for AREA in "${!_ht_dirs[@]}"; do printf "%3d  %s \n" "${_ht_dirs[$AREA]}" "${AREA}"; done | sort -n -k1)
  pathNum=$(echo "$paths" | fzf --height 30%) &&
    path=$(echo "${pathNum}" | sed -e "s/[ 0-9]*[ ]*\([^\n]*\)/\1/g") &&
    path=$(echo "${path}" | sed -e 's/ *$//') &&
    cd "$path" &&
    echo move to "$path"
}


if [[ -t 1 ]]; then
  bind -x '"\C-t"':_seeDirs
fi