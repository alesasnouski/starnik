import Config

config :starnik, Starnik.Repo,
  database: "starnik",
  username: "starnik",
  password: "starnik",
  hostname: "localhost"

config :starnik, ecto_repos: [Starnik.Repo]

config :starnik, Plugs.Graphql.Context, admin_auth_token: ""

import_config "#{config_env()}.exs"

if File.exists?("config/#{config_env()}.secret.exs"),
  do: import_config("#{config_env()}.secret.exs")
