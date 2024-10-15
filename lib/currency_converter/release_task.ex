defmodule CurrencyConverter.ReleaseTask do
  @app :currency_converter

  def run_migration do
    run_ecto_migration()
    :ok
  end

  def run_ecto_migration do
    Application.load(@app)

    {:ok, _} = Application.ensure_all_started(:ssl)

    repos = Application.fetch_env!(@app, :ecto_repos)

    for repo <- repos do
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end
end
