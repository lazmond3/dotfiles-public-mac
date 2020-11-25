
function github-topic-search() {
    local fname="github-topic-api-$1.json"
    if [ -e "$fname" ]; then rm "$fname"; fi
    curl -H 'Accept: application/vnd.github.mercy-preview+json' 'https://api.github.com/search/topics?q='"$1" | tee  "$fname"
    yqq "$fname"
}

function github-topic-repos() {
    
    local fname="github-search-repo-api-$1.json"
    if [ -e "$fname" ]; then rm "$fname"; fi
    curl -H 'Accept: application/vnd.github.mercy-preview+json' "https://api.github.com/search/repositories?q=stars:<=20+topic:$1&sort=stars&order=desc" | tee  "$fname"
    yqq "$fname"
}

function github-topic-repos-rust() {
    local fname="rust-github-search-repo-api-$1.json"
    local q="q=topic:$1+language:rust"
    if [ -e "$fname" ]; then rm "$fname"; fi
    if [ $2 ]; then
        q="$q+stars:>=$2"
    else
        :
    fi
    curl -H 'Accept: application/vnd.github.mercy-preview+json' "https://api.github.com/search/repositories?$q&sort=stars&order=desc" | tee  "$fname"

    yqq "$fname"
}