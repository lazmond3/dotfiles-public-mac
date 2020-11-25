# PS1 configuration
# TODO: PS1_HOOKSという変数をリストループを使って展開しても面白いかも
function set_ps1() {
  local WHITE="\[\e[00m\]"
  local RED="\[\e[31m\]"
  local GREEN="\[\e[32m\]"
  local YELLOW="\[\e[33m\]"
  local BLUE="\[\e[34m\]"
  local CYAN="\[\e[36m\]"
  local GREEN2="\[\e[30m\]"
  local GRAY="\[\e[37m\]"

  local B='\[\e[1;38;5;33m\]'
  local GY='\[\e[1;38;5;242m\]'
  local P='\[\e[1;38;5;161m\]'
  local R='\[\e[1;38;5;196m\]'
  local W='\[\e[0m\]'

  local Y='\[\e[1;38;5;214m\]'
  local USER='\u'
  local HOST='\h'
  local DIRR='\w'

  function get_branch_name() {
    git branch 2>/dev/null | sed -e "/^[^*]/d" -e "s/* \(.*\)/ (\1) /"
  }

  export PS1="${GY}[${Y}${USER}${GY}@${W}${HOST}${GY}:${B}${DIRR}${GY}] \`cat ~/.hostenv\` \`if [ \$? = 0 ];then echo ${GREEN2}; else echo ${RED}; fi\`\`get_branch_name\`\n$ ${W}"

}
set_ps1
