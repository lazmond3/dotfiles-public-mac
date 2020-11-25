###########################
## cd history fzf ## ここでトグルしたい！
###########################

function cd() {
  builtin cd $@
  ls
}
