
###########################
## fzf wiki
###########################
# TODO: このファイルでかすぎ！分割していいと思う

# fbr - change branch
# fbr - checkout git branch (including remote branches)
function ffbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
      fzf -d $((2 + $(wc -l <<<"$branches"))) +m) &&
    echo $branch
}
function fbr() {
  local branches branch
  branches=$(git branch --all | grep -v HEAD) &&
    branch=$(echo "$branches" |
      fzf -d $((2 + $(wc -l <<<"$branches"))) +m) &&
    git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}


# fshow - git commit browser
function fdshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF" \
      --preview "git diff --name-status --color=always \"\$(echo {} | grep -E \" ([a-z0-9]+) \" -o | head -n1 | tr -d ' '  )^\"  \$(echo {} | grep -E \" ([a-z0-9]+) \" -o | head -n1)"
}
function fshow() {
  git log --graph --color=always \
    --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
    fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF" \
      --preview "git diff  --color=always \"\$(echo {} | grep -E \" ([a-z0-9]+) \" -o | head -n1 | tr -d ' '  )^\"  \$(echo {} | grep -E \" ([a-z0-9]+) \" -o | head -n1)"
}

fzf-down() {
  fzf --height 50% "$@" --border
}



function gsu() {
  version=$(git --version | myawk 3)
  version=${version%.*} #2.X
  local untr_margin=2
  if [[ $is_wsl == 1 ]]; then
    local untr_margin=2
  elif [[ $is_mac == 1 ]]; then
    local untr_margin=1
  fi

  r2="$(git -c color.status=always status | _after_t Untr $untr_margin)"
  rr="$(git -c color.status=always status)"

  while read -r line; do
    echo -e "\tUntracked:  $line"
  done < <(echo -e "$r2")
}

## Untrackedは表示しない
function gs() {
  result=$(git -c color.status=always status | grep -E "(new file|deleted|modified|renamed|both modified):(.*)$")
  r2=$(git -c color.status=always status | _after_t Untr $untr_margin)
  echo -e "$result"
}

function gigifu() {
  is_in_git_repo || return

  local out result
  local lineNum
  lineNum=$(git status | tail -n +5 | grep -n Untr | cut -f1 -d:)
  lineNum=$(($lineNum - 2))

  out=$(gsu | fzf --height=20 --reverse -m --ansi --preview 'echo {} | sed -e "s/^([ \t]*)$//"  | cut -d: -f2  | awk "{print $1}" | xargs git diff --color=always  ')

  while read line; do
    if [[ "$line" =~ "both modified" ]]; then
      echo $(echo "$line" | awk '{print $3}')
      continue
    fi

    awk1=$(echo "$line" | awk '{print $1}')
    awk2=$(echo "$line" | awk '{print $2}')
    if [ -z "$awk2" ]; then
      result="${result}\n${awk1}"
    else
      result="${result}\n${awk2}"
    fi
  done < <(echo -e "$out")
  result="${result:2}"
  echo -e "$result"
}

function gigif() {
  is_in_git_repo || return

  local out result
  local lineNum
  lineNum=$(git status | tail -n +5 | grep -n Untr | cut -f1 -d:)
  lineNum=$(($lineNum - 2))

  out=$(gs | fzf --height=20 --reverse -m --ansi --preview 'echo {} | sed -e "s/^([ \t]*)$//"  | cut -d: -f2  | awk "{print $1}" | xargs git diff --color=always  ')

  while read line; do
    if [[ "$line" =~ "both modified" ]]; then
      echo $(echo "$line" | awk '{print $3}')
      continue
    fi

    awk1=$(echo "$line" | awk '{print $1}')
    awk2=$(echo "$line" | awk '{print $2}')
    if [ -z "$awk2" ]; then
      result="${result}\n${awk1}"
    else
      result="${result}\n${awk2}"
    fi
  done < <(echo -e "$out")
  result="${result:2}"
  echo -e "$result"
}

function gia() {
  # 改正案
  # git-select-files-with-fzf
  # git-select-files-with-fzf-unstaged
  git add $(gigif)
}

function giau() {
  git add $(gigifu)
}

function push() {
  if [ $# = 0 ]; then
    git push origin $(git branch | grep "*" | awk '{print $2}')
    return
  fi
  git push origin "${1}"
}

function push2() {
  if [ $# = 0 ]; then
    git push origin2 $(git branch | grep "*" | awk '{print $2}')
    return
  fi
  git push origin2 "${1}"
}
function pushf2() {
  if [ $# = 0 ]; then
    git push origin2 $(git branch | grep "*" | awk '{print $2}') -f
    return
  fi
  git push origin2 "${1}" -f
}

function pull2() {
  if [ $# = 0 ]; then
    git pull origin2 $(git branch | grep "*" | awk '{print $2}')
    return
  else
    echo "no args.. "
  fi
}
function fetch2() {
  fetch
}

function pushf() {
  if [ $# = 0 ]; then
    git push origin $(git branch | grep "*" | awk '{print $2}') -f
    return
  fi
  git push origin "${1}" -f
}

function fetch() {
  git fetch --all
}
function pull() {
  if [ $# = 0 ]; then
    git pull origin $(git branch | grep "*" | awk '{print $2}')
    return
  else
    echo "no args.. "
  fi
}


###########################
## GIT
###########################
function lc() {
  git commit -m "$*"
}



# git init
function ggignore() {
  if [[ $# > 0 ]]; then
    for f in "$@"; do
      echo "$f" >>.gitignore
    done
  else
    local files="$(ls -a | fzf -m)"
    for f in "$files"; do
      echo "$f" >>.gitignore
    done
  fi
}


function gsapp() {
  if [[ $# == 0 ]]; then
    git stash apply stash@{0}
  else
    git stash apply stash@{$1}
  fi

}
