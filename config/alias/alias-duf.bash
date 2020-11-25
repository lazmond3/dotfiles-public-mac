if [ $is_mac == 1 ]; then
    alias duf="sudo du -h -d 1  | sort -h | tee DUFLOG"
fi
