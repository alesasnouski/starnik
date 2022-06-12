defmodule Starnik.Middlewares.Authenticate do
  @moduledoc """
  Provides middleware to require an authenticated user for GraphQL requests.
  """
  @behaviour Absinthe.Middleware

  @not_authenticated {:error, :not_authenticated}

  def call(resolution, _config) do
    case resolution.context do
      %{current_user: _} -> resolution
      _ -> Absinthe.Resolution.put_result(resolution, @not_authenticated)
    end
  end
end
