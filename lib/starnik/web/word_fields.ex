defmodule Starnik.Schema.WordFields do
  @moduledoc false

  use Absinthe.Schema.Notation
  alias Starnik.Middlewares.Authenticate

  @desc "A word"
  object :word do
    field(:id, non_null(:id))
    field(:word, non_null(:string))
    field(:word_reverse, non_null(:string))
    field(:inserted_at, :datetime)
  end

  @desc "Get a list of words"
  object :word_queries do
    field :words, list_of(:word) do
      arg(:limit, :integer)
      arg(:length, :integer)
      arg(:starts_with, :string)
      arg(:ends_with, :string)
      arg(:contains_letters, :string)
      arg(:excludes_letters, :string)
      arg(:order, :string)
      arg(:like, :string)
      resolve(&Resolvers.Words.list_words/2)
    end
  end

  object :word_mutations do
    field :create_words, list_of(:word) do
      arg(:words, list_of(:string))
      middleware(Authenticate)
      resolve(&Resolvers.Words.create_words/2)
    end

    field :remove_word, :word do
      arg(:word, :string)
      middleware(Authenticate)
      resolve(&Resolvers.Words.remove_word/2)
    end
  end
end
