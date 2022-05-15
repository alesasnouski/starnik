defmodule Resolvers.Words do
  def list_words(args, %{context: context}) do
    IO.inspect(inspect(args))
    {:ok, []}
  end
end
