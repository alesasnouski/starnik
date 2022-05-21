# Starnik

**TODO: Add description**

```
query($startsWith:String, $limit:Int, $endsWith:String, $length:Int, $containsLetters:String, $excludesLetters:String, $like:String){
  words(startsWith:$startsWith, limit:$limit, endsWith:$endsWith,
    length:$length, containsLetters:$containsLetters, excludesLetters:$excludesLetters, like:$like) {
    word,
    insertedAt,
    id
  }
}
```