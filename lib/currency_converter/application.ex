defmodule CurrencyConverter.Application do
  use Application

  @env Mix.env()

  @default_max_restarts 10

  def start(_type, _args) do
    children = children(@env)

    opts = [
      strategy: :one_for_one,
      name: CurrencyConverter.Supervisor,
      max_restarts: supervisor_max_restarts()
    ]

    Supervisor.start_link(children, opts)
  end

  defp children(test_env) when test_env in [:test] do
    [
      {Phoenix.PubSub, name: CurrencyConverter.PubSub},
      CurrencyConverter.Repo,
      CurrencyConverterWeb.Endpoint
    ]
  end

  defp children(_) do
    [
      CurrencyConverter.Cluster,
      {Phoenix.PubSub, name: CurrencyConverter.PubSub},
      CurrencyConverter.Repo,
      CurrencyConverterWeb.Endpoint
    ]
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    CurrencyConverterWeb.Endpoint.config_change(changed, removed)
    :ok
  end

  defp supervisor_max_restarts do
    Application.get_env(:currency_converter, :supervisor_max_restarts, @default_max_restarts)
  end
end
