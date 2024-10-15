defmodule CurrencyConverter.Repo.Migrations.AddTransactionProjector do
  use Ecto.Migration

  def change do
    create table("currency_conversion_rates") do
      add :from_currency, :string, null: false
      add :to_currency, :string, null: false
      add :exchange_rate, :decimal, null: false

      timestamps(type: :utc_datetime_usec)
    end

    create index("currency_conversion_rates", [:from_currency, :to_currency])
  end
end
