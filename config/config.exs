# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :currency_converter,
  ecto_repos: [CurrencyConverter.Repo]

config :currency_converter,
  supervisor_max_restarts: 10

# Configures the endpoint
config :currency_converter, CurrencyConverter.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "OrAg1VfnLCmsGE1EDRiw8RIl3aqJ3M9i2nUCwS5tS9HC0kIjk8e2otCTfq7gPDMy",
  render_errors: [view: CurrencyConverter.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: CurrencyConverter.PubSub,
  live_view: [signing_salt: "W28ZODVq"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id, :stream_uuid, :trace_id, :span_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
