
ES_HOST="localhost:9200"
TW="twinttweets"
alias toy="yq r --prettyPrint -"
alias toj="yq r -j -"
CONT="-H \"Content-Type: application/json\" "
function es_cat_ind() {
    
    if [ $# == 1 ]; then
        :
        indexName=$1
        curl -XGET "$ES_HOST/$indexName/_settings?pretty"
    else
        curl -XGET "$ES_HOST/_cat/indices?v"
    fi
}
function es_mapping() {
    
    if [ $# == 1 ]; then
        :
        indexName=$1
        curl -XGET "$ES_HOST/$indexName/_mapping?pretty"
    else
        echo error index name
    fi
}

function es_command() {
    if [ $# -lt 1 ]; then
        echo error args '$1' must be 3
        return
    fi
    indexName=$2
    fileName=$3

    case $1 in
        "count")   curl -sS $CONT -XGET "$ES_HOST/${indexName}/_count?pretty" ;;
        "count2")  curl -sS -H "Content-Type: application/json" -XGET "$ES_HOST/${indexName}/_count?pretty" -d  "$(cat $fileName | toj)" ;;
        "search")  curl -sS -H "Content-Type: application/json" -XGET "$ES_HOST/${indexName}/_search?pretty" -d "$(cat $fileName | toj)" ;;
        # "search") cat $fileName | toj ;;
    esac

}

function twint_get() {
    twint -u $1 -es localhost:9200 
}

function twint_following() {
    twint -u $1 --following | tee $1-following.json
}

function twint_cmd() {
    case $1 in 
    "get") twint -u $2 -es localhost:9200;;
    # "following") twint -u $2 --following    | tee $2-following.txt;; # かなりエラーになりがち
    "favorites") twint -u $2 --favorites    | tee $2-favorites.txt ;;
    # "profile")   twint -u $2 --profile-full | tee $2-profile.txt ;;
    esac
}


## SEARCHについて
# - cat oba.yml  | toj | jq  '{hits} | {hits} | {hits} | .hits.hits[]._source.tweet ' | less
# query:
#  match:
#   username: obashuji
# "本当にこの工程比較なのかと思って比較してこのレシピに落ち着ついてる。"
# "そうか、ハンバーグなんて簡単なのになんでみんなそんなめんどくさがるのかと思ったら玉ねぎ炒めるとか牛乳に浸すとか素直に従ってるからか。「肉に塩振って粘りが出るまで練り、胡椒・(あればナツメグ)・玉ねぎ・パン粉入れて混ぜて整形して焼く」
# だけですよ俺。十分美味しいと思う"
# "一昨年のも「平成30年7月豪雨」だよね"
# "玉ねぎなんか極端な話別になくてもいいんじゃないかと思う"
# "パン粉は吸水剤で、これがないと水分が流出して固く縮んだハンバーグになる。入れてもそうなるならパン粉の量が足りない。計量してないでカンなんだけど一度レシピ作っとくかな"
# "それよりパン粉がだいじ。牛乳に浸す必要もなし。直で入れる"
# "玉ねぎの役目、単純にグルタミン追加ぐらいだと思ってるので炒めてから冷ますという工程の面倒さが効果に釣り合ってないと感じてカットしてる。あまり違いもわからない"
# "内訳見ないとってのもあるんだけど、世間の動きはこの数値に反応するのは間違いないからそういう意味ではやはりこの数値そのものを重視せざるをえない。"
# "たぶん都民お断りの山小屋増えるな。しばらくは都外の山小屋に頼る登山はやりにくい"
# "ハンバーグなんてどうやっても肉の塊なんだから美味いんだけど、しかし工夫すればするほどさらに美味くなってしまうのでけっこう差がつくいう意味では厄介な料理"

# count2でも、指定してあげることで探せる
# analyzer興味あるなあ、どうやって使えるんだろう
# Count API | Elasticsearch Reference [7.8] | Elastic https://www.elastic.co/guide/en/elasticsearch/reference/current/search-count.html


## TWITTER

twurl="https://api.twitter.com/oauth2/token"
twu="https://api.twitter.com"
twut="$twu/1.1/statuses/user_timeline.json"
bbb="dW42TzEyT2xtODBIZmhxU25lelpXZkg2VDpmRTFacFVqMGJOSUNTSGlleXQ3M3dabk9FUHVXdVY4UFhHcUNzUEFvNU95WTVPS2I3MQ=="
at="AAAAAAAAAAAAAAAAAAAAAMKdYQAAAAAAuCtNURuSaoN441gr74lgdtaCx1U%3DhcfWqkyFK0P0sTm3sVqHFe5zKF1YaigxRmirW9fZMwRKiDce4I"
function ctw_init() {
    curl -X POST  \
      -H "User-Agent: MyTwitterAppCurl v0.0" \
      -H "Authorization: Basic ${bbb}" \
      -d "grant_type=client_credentials"  \
      $twurl  | jq ".access_token"  |  tee token
}
function ctw_ut() {
    local opt="?count=100&screen_name=testanto6"
    curl -X GET \
      -H "User-Agent: MyTwitterAppCurl v0.0" \
      -H "Authorization: Bearer ${at}" \
      "$twut$opt"  |  jq . | tee $1
}
function ctw_getfollowing() {
    local cursor="-1"
    local username=$1
    local opt="?count=100&screen_name=$username"
    if [ $# = 2 ]; then
        cursor=$2
        opt="$opt&cursor=$cursor"
    fi

    local twfuid="$twu/1.1/statuses/friends/list.json"
    local url="https://api.twitter.com/1.1/friends/list.json"
    curl -X GET \
      -H "User-Agent: MyTwitterAppCurl v0.0" \
      -H "Authorization: Bearer ${at}" \
      "$url$opt"  |  jq . | tee $1-folloginw.json
}

## ユーザ認証を試してみる
function cuserp_request_token() {
    local url="https://api.twitter.com/oauth/request_token"
    curl -X POST \
     \
     $url
}