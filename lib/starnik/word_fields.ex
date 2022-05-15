defmodule Starnik.Schema.WordFields do
  @moduledoc false

  use Absinthe.Schema.Notation

  @desc "A word"
  object :word do
    field(:id, non_null(:id))
    field(:word, non_null(:string))
    field(:inserted_at, :datetime)
  end

  @desc "Get a list of words"
  object :word_queries do
    field :words, list_of(:word) do
      arg(:limit, :integer)
      resolve(&Resolvers.Words.list_words/2)
    end
  end
end
