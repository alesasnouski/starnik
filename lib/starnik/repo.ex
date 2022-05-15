defmodule Starnik.Repo do
  use Ecto.Repo,
    otp_app: :starnik,
    adapter: Ecto.Adapters.Postgres
end
