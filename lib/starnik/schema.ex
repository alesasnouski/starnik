defmodule Starnik.Word do
  @moduledoc false

  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  @derive Jason.Encoder

  schema "words" do
    field(:word, :string)
    timestamps(type: :utc_datetime, updated_at: false)

    def starts_with(query \\ __MODULE__, val) do
      prefix = "#{val}%"
      from(q in query, where: like(q.word, ^prefix))
    end

    def by_containing_letters(query \\ __MODULE__, val) do
      String.graphemes(val)
      |> Enum.reduce(query, fn v, acc ->
        from(q in query, where: fragment("? ~ ?", q.word, ^v))
      end)
    end

    def by_excluding_letters(query \\ __MODULE__, val) do
      String.graphemes(val)
      |> Enum.reduce(query, fn v, acc ->
        from(q in query, where: fragment("? !~ ?", q.word, ^v))
      end)
    end

    def ends_with(query \\ __MODULE__, val) do
      suffix = "%#{val}"
      from(q in query, where: like(q.word, ^suffix))
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
