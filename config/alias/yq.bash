function yqq() {
    # yq r $1

    # echo will do : $1 ${1%.json}.yml
    # return
    if [ -f ${1%.json}.yml ]; then
        rm ${1%.json}.yml
    fi
    yq r $1 --prettyPrint >  ${1%.json}.yml
}

function yqindir() {
    for i in $(ls *.json); do
        yqq $i;
    done
}