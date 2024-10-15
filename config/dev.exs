import Config

config :currency_converter, CurrencyConverter.Repo,
  username: "postgres",
  password: "postgres",
  database: "currency_converter_dev",
  hostname: "localhost",
  show_sensitive_data_on_connection_error: true,
  pool_size: 2

config :currency_converter, CurrencyConverterWeb.Endpoint,
  http: [port: 10000],
  debug_errors: true,
  code_reloader: true,
  check_origin: false,
  watchers: []

config :currency_converter, CurrencyConverter.PromEx, disabled: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime
