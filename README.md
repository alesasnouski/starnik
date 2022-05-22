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

### Start containers:
  cd local_env && docker-compose up -d

### Start application:
  mix deps get 
  mix ecto.migrate
  mix run priv/repo/seeds/seeds.exs  # copy txt file into requested path if needed
  iex -S mix
  
  Proceed to http://localhost:8000/graphiql to execute query:

```
query($startsWith:String, $limit:Int, $endsWith:String, $length:Int, $containsLetters:String, $excludesLetters:String, $like:String){
  words(startsWith:$startsWith, limit:$limit, endsWith:$endsWith,
    length:$length, containsLetters:$containsLetters, excludesLetters:$excludesLetters, like:$like) {
    word,
    insertedAt,
    id
  }
}

Variables:
{
  "containsLetters": "б",
  "excludesLetters": "де",
  "length": 7,
  "like": "_юби",
  "limit": 100,
  "startsWith": "л"
}

```

The same query can be sent to API /api endpoint like\
http://localhost:8000/api?query=query(.........