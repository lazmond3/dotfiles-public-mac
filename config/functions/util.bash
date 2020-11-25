function dia() { export DISPLAY=$1; }

function iif() {
  while :; do
    $@
    sleep 1
  done
}

function infls() {
  while :; do
    ls -rlth
    sleep 0.2
  done
  # TODO: たぶん inf "ls -rtlh" でできる。
}
