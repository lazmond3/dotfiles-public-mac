function bakr() { mv $1 ${1}.bak; }
function cpbak() { cp $1 ${1}.bak; }
function unbak() {
  if [ $(echo $1 | grep ".bak") ]; then
    mv $1 ${1%.bak}
  else
    echo "Error: $1 is not a .bak file."
  fi
}

# mkdir and cd
function mcd() {
  if [ ! -e $1 ]; then
    mkdir -p $1 && builtin cd -- $1 && ls
  fi
}
