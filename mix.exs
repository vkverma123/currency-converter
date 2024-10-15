defmodule CurrencyConverter.MixProject do
  use Mix.Project

  def project do
    [
      app: :currency_converter,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: [:phoenix] ++ Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps(),
      dialyzer: [plt_core_path: "_build/#{Mix.env()}", plt_add_apps: [:ex_unit]]
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {CurrencyConverter.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      # deps
      {:lib, path: "submodules/lib"},
      {:ecto_sql, "~> 3.10"},
      {:jason, "~> 1.0"},
      {:libcluster, "~> 3.3"},
      {:logger_json, "~> 5.0"},
      {:phoenix_ecto, "~> 4.4.0"},
      {:phoenix_pubsub, "~> 2.0"},
      {:phoenix, "~> 1.6.2"},
      {:plug_cowboy, "~> 2.5.2"},
      {:postgrex, ">= 0.0.0"},
      {:prom_ex, "~> 1.5"},
      {:ex_machina, "~> 2.7", [only: :test]},
      {:telemetry, "~> 1.0"},
      {:bypass, "~> 2.1", only: :test},
      {:elixir_uuid, "~> 1.2.1"},
      {:timex, "~> 3.7.6"},
      {:ssl_verify_fun, "~> 1.1.7", manager: :rebar3, override: true},
      # dev
      {:assert_eventually, "~> 1.0.0", only: [:dev, :test]},
      {:credo, "~> 1.6.1", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:mimic, "~> 1.5", only: :test}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "ecto.setup"],
      reset: ["ecto.reset"],
      "ecto.setup": ["ecto.create", "ecto.migrate"],
      "ecto.reset": ["ecto.drop", "ecto.setup"],
      test: ["ecto.setup", "test"],
      "ecto.seeds": ["run priv/repo/seeds.exs"],
      "dev.reset": ["ecto.reset", "es.reset", "ecto.seeds"]
    ]
  end
end
