if [ $is_mac = 1 ]; then
    alias pp="pwd | tr -d \"\n\" | pb"
    alias gg="git branch --contains=HEAD | myawk 2 | pb"
fi