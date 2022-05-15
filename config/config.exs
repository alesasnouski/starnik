import Config

config :starnik, Starnik.Repo,
  database: "starnik",
  username: "starnik",
  password: "starnik",
  hostname: "localhost"

config :starnik, ecto_repos: [Starnik.Repo]

import_config "#{config_env()}.exs"

if File.exists?("config/#{config_env()}.secret.exs"),
  do: import_config("#{config_env()}.secret.exs")
