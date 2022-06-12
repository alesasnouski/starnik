defmodule Plugs.Graphql.Context do
  @moduledoc """
  Provides a plug-based context builder for GraphQL requests.
  """
  @behaviour Plug
  require Logger

  import Plug.Conn

  def init(opts), do: opts

  def call(conn, _) do
    case build_context(conn) do
      {:ok, context} -> put_private(conn, :absinthe, %{context: context})
      _ -> conn
    end
  end

  defp build_context(conn) do
    cond do
      # Check for authorization header first
      user = authorize_from_header(conn) ->
        {:ok, %{current_user: user}}

      true ->
        nil
    end
  end

  defp authorize_from_header(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user} <- authorize_from_token(token) do
      user
    else
      _ -> nil
    end
  end

  defp authorize_from_token(token) do
    env = Application.get_env(:starnik, __MODULE__)
    config_token = Keyword.get(env, :admin_auth_token)

    case token do
      ^config_token -> {:ok, :admin}
      _ -> {:error, :not_found}
    end
  end
end
