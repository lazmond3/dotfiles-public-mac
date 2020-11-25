###########################
## TMUX
###########################
function ta() {
  local name="$(tmux list-sess | fzf | myawk 1)"
  name=${name:0:-1}
  tmux a -t "$name"
}

function tn() {
  tmux new -s $1
}
