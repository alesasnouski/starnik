Path.join(:code.priv_dir(:starnik), "ru_words.txt")
|> File.stream!()
|> Enum.map(&String.trim/1)
|> Enum.map(&String.downcase/1)
|> Enum.filter(fn word -> String.length(word) > 2 && String.length(word) < 30 end)
|> Enum.chunk_every(100)
|> Enum.map(fn words ->
    slice = Enum.map(words, fn word ->
      %{word: word, word_reverse: String.reverse(word)}
    end)
    Starnik.Repo.insert_all(Starnik.Word, slice, [])
end)

IO.puts("Loading anagrams ...")

Path.join(:code.priv_dir(:starnik), "ru_words.txt")
|> File.stream!()
|> Enum.map(&String.trim/1)
|> Enum.map(&String.downcase/1)
|> Enum.filter(fn word -> String.length(word) > 2 && String.length(word) < 30 end)
|> Enum.map(fn word ->

  letters = word
    |> String.graphemes()
    |> Enum.sort
    |> Enum.join

  sql = """
  INSERT INTO anagrams(letters, words) VALUES ($1, ARRAY[$2]) ON CONFLICT(letters) DO UPDATE SET words = anagrams.words || ARRAY[$3];
  """
  Ecto.Adapters.SQL.query(Starnik.Repo, sql, [letters, word, word])
end)
