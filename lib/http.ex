defmodule Starnik.HTTP.API do
  @moduledoc false
  require Logger

  use Plug.Router
  use Plug.ErrorHandler

  plug(Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json, Absinthe.Plug.Parser],
    pass: ["*/*"],
    json_decoder: Jason
  )

  plug(:match)
  plug(:dispatch)

  forward("/api",
    to: Absinthe.Plug,
    init_opts: [schema: Starnik.Schema]
  )

  forward("/graphiql",
    to: Absinthe.Plug.GraphiQL,
    init_opts: [
      schema: Starnik.Schema,
      interface: :simple
    ]
  )
end

defmodule Starnik.HTTP do
  @moduledoc false
  use Plug.Builder
  plug(Starnik.HTTP.API, [])

  def start_link do
    http_conf = Application.get_env(:starnik, Starnik.HTTP, [])

    {:ok, _} =
      Plug.Adapters.Cowboy.http(Starnik.HTTP, [],
        port: Keyword.get(http_conf, :port, 8000),
        protocol_options: Keyword.get(http_conf, :protocol_options, [])
      )
  end

  def child_spec(_args) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, []}
    }
  end
end
