defmodule Resolvers.Words do
  import Ecto.Query

  @limit_default 500
  @order_default [asc: :word]
  @limit_max 2000

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

    ordered_query = case Map.get(query, :order_by) do
      nil -> from(q in query, order_by: ^@order_default)
      _ -> query
    end

    data =
      from(q in ordered_query)
      |> Starnik.Repo.all()

    {:ok, data}
  end
end
