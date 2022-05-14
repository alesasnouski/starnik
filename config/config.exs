import Config

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"

if File.exists?("config/#{config_env()}.secret.exs"),
  do: import_config("#{config_env()}.secret.exs")
