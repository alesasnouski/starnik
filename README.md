# Starnik

## Dev env setup:

### Erlang setup:
  brew install kerl\
  kerl list releases\
  kerl build 25.0\
  kerl install 25.0 ~/workspace/ekerl/25.0\
  . ~/workspace/ekerl/25.0/activate

### Elixir setup:
  brew install kiex\
  kiex update\
  kiex install 1.13.4

### Elixir MacOS setup:
\curl -sSL https://raw.githubusercontent.com/taylor/kiex/master/install | bash -s\
test -s "$HOME/.kiex/scripts/kiex" && source "$HOME/.kiex/scripts/kiex"\
kiex install 1.13.4\
kiex use 1.13.4


### Start containers:
  cd local_env && docker-compose up --build -d

### Start application:
  mix deps get \
  mix ecto.migrate \
  mix run priv/repo/seeds/seeds.exs  # copy txt file into requested path if needed \
  iex -S mix
  
  Proceed to http://localhost:8000/graphiql to execute query:

```
query($startsWith:String, $limit:Int, $endsWith:String, $length:Int, $containsLetters:String, 
  $excludesLetters:String, $like:String, $order:String){
  words(startsWith:$startsWith, limit:$limit, endsWith:$endsWith,
    length:$length, containsLetters:$containsLetters, excludesLetters:$excludesLetters, like:$like) {
    word,
    id
  },
  words_reversed: words(startsWith:$startsWith, limit:$limit, endsWith:$endsWith,
    length:$length, containsLetters:$containsLetters, excludesLetters:$excludesLetters, like:$like, order:$order) {
    word,
    id
  }
}

{
  "length": 7,
  "limit": 100,
  "startsWith": "оба",
  "order": "word_reverse",
  "excludesLetters": "гмжюя"
}

```

### Start Front-End:
Start dev server: \
cd assets && npm run dev \
Proceed to http://localhost:3000

Build assets: \
npm run build