defmodule Starnik.Application do
  @moduledoc false

  def start(_type, _args) do
    children = [
      Starnik.HTTP
    ]

    opts = [strategy: :one_for_one, name: Starnik.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
