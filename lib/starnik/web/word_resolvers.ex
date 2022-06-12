defmodule Resolvers.Words do
  import Ecto.Query

  require Logger

  @limit_default 500
  @order_default [asc: :word]
  @limit_max 2000
  @insert_batch_size 100
  @min_word_length 2
  @max_word_length 30

  def remove_word(%{word: word}, %{context: _context}) do
    case Starnik.Repo.get_by(Starnik.Word, word: word) do
      nil ->
        {:ok, nil}

      w ->
        Starnik.Repo.delete(w)
        {:ok, w}
    end
  end

  def create_words(%{words: words}, %{context: _context}) do
    slices =
      words
      |> Enum.map(&String.trim/1)
      |> Enum.map(&String.downcase/1)
      |> Enum.filter(fn word ->
        String.length(word) > @min_word_length && String.length(word) < @max_word_length
      end)
      |> Enum.chunk_every(@insert_batch_size)

    slices
    |> Enum.map(fn words ->
      slice =
        Enum.map(words, fn word ->
          %{
            word: word,
            word_reverse: String.reverse(word)
          }
        end)

      {inserted, nil} = Starnik.Repo.insert_all(Starnik.Word, slice, on_conflict: :nothing)
      Logger.info("Inserted #{inserted} new words.")
    end)

    words =
      slices
      |> Enum.map(fn words ->
        from(q in Starnik.Word, where: q.word in ^words)
        |> Starnik.Repo.all()
      end)
      |> List.flatten()

    {:ok, words}
  end

  def list_words(args, %{context: _context}) do
    schema = Starnik.Word
    base_query = from(q in schema, limit: @limit_default)

    query =
      Enum.reduce(args, base_query, fn
        {:starts_with, val}, query ->
          schema.starts_with(query, val)

        {:ends_with, val}, query ->
          schema.ends_with(query, val)

        {:length, val}, query ->
          schema.by_length(query, val)

        {:contains_letters, val}, query ->
          schema.by_containing_letters(query, val)

        {:excludes_letters, val}, query ->
          schema.by_excluding_letters(query, val)

        {:like, val}, query ->
          schema.like(query, val)

        {:order, val}, query ->
          schema.order_by(query, val)

        {:limit, limit}, query ->
          limited =
            case limit do
              a when is_integer(a) and a > @limit_max -> @limit_max
              b when is_integer(b) -> b
              _ -> @limit_default
            end

          from(q in query, limit: ^limited)

        _, query ->
          query
      end)

    ordered_query =
      case Map.get(query, :order_by) do
        nil -> from(q in query, order_by: ^@order_default)
        _ -> query
      end

    data =
      from(q in ordered_query)
      |> Starnik.Repo.all()

    {:ok, data}
  end
end
