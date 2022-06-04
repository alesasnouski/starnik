defmodule Starnik.Word do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Query

  @derive Jason.Encoder

  @sort_order_default [asc: :word]

  schema "words" do
    field(:word, :string)
    field(:word_reverse, :string)
    timestamps(type: :utc_datetime, updated_at: false)

    def starts_with(query \\ __MODULE__, val) do
      prefix = "#{val}%"
      from(q in query, where: like(q.word, ^prefix))
    end

    def by_containing_letters(query \\ __MODULE__, val) do
      String.graphemes(val)
      |> Enum.reduce(query, fn v, acc ->
        from(q in acc, where: fragment("? ~ ?", q.word, ^v))
      end)
    end

    def by_excluding_letters(query \\ __MODULE__, val) do
      String.graphemes(val)
      |> Enum.reduce(query, fn v, acc ->
        from(q in acc, where: fragment("? !~ ?", q.word, ^v))
      end)
    end

    def order_by(query \\ __MODULE__, val) do
      sort_order = get_sort_order_by(val)
      from(q in query, order_by: ^sort_order)
    end

    defp get_sort_order_by(val) do
      split_val =
        val
        |> String.trim()
        |> String.split(" ")

      case split_val do
        ["word", "desc"] -> [desc: :word]
        ["word", "asc"] -> [asc: :word]
        ["word"] -> [asc: :word]
        ["word_reverse", "desc"] -> [desc: :word_reverse]
        ["word_reverse", "asc"] -> [asc: :word_reverse]
        ["word_reverse"] -> [asc: :word_reverse]
        _ -> @sort_order_default
      end
    end

    def ends_with(query \\ __MODULE__, val) do
      suffix = "#{val}%"
      from(q in query, where: like(q.word_reverse, ^suffix))
    end

    def like(query \\ __MODULE__, val) do
      real_val = "%#{val}%"
      from(q in query, where: like(q.word, ^real_val))
    end

    def by_length(query \\ __MODULE__, val) do
      from(q in query, where: fragment("length(?)", q.word) == ^val)
    end
  end
end
