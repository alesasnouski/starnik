Path.join(:code.priv_dir(:starnik), "ru_words.txt")
|> File.stream!()
|> Enum.map(&String.trim/1)
|> Enum.filter(fn word -> String.length(word) > 4 && String.length(word) < 10 end)
|> Enum.chunk_every(100)
|> Enum.map(fn words ->
    slice = Enum.map(words, fn word ->
      %{word: word}
    end)
    Starnik.Repo.insert_all(Starnik.Word, slice, [])
end)
