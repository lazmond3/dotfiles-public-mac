###########################
## ELS CURL
###########################
alphaels=https://castservice-1:xapC5EVkFRh962nJ@castservice-api-linelive.line-ves-dev.com:12000
function calpha() {
  JSONOPT="-H \"Content-Type:application/json\" "
  if [[ $1 =~ .*_cat/.* ]]; then
    echo _cat
    echo cmd: "curl -X $2  \"$alphaels/$1\" "
    curl -X $2 "$alphaels/$1"
  elif [[ $1 =~ .*sgen/.* ]]; then
    echo sgen
    echo cmd: "curl -X $2  \"$alphaels/$1\" "
    curl -X $2 "$alphaels/$1"
  elif [[ $2 == "GET" ]]; then
    local ac="$alphaels/linelive-beta/$1"
    echo ac: $ac
    curl -X $2 "$alphaels/linelive-beta/$1"
  elif [[ $2 == "POST" ]]; then
    echo in POST
    echo cmd: "curl -X $2 $JSONOPT  $alphaels/linelive-beta/$1  -d $3"
    curl -X $2 $JSONOPT $alphaels/linelive-beta/$1 -d $3
  else
    curl -X $2 $JSONOPT $alphaels/linelive-beta/$1
  fi
}
