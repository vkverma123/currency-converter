defmodule CurrencyConverter.CurrencyConversionRate do
  use Ecto.Schema
  import Ecto.Changeset

  @type t :: %__MODULE__{}

  @primary_key {:id, :id, autogenerate: true}
  schema "currency_conversion_rates" do
    field :from_currency, :string
    field :to_currency, :string
    field :exchange_rate, :decimal

    timestamps(type: :utc_datetime_usec)
  end

  @doc false
  def changeset(currency_conversion_rates, attrs) do
    currency_conversion_rates
    |> cast(attrs, [:from_currency, :to_currency, :exchange_rate])
    |> validate_required([:from_currency, :to_currency, :exchange_rate])
    |> unique_constraint([:from_currency, :to_currency])
  end
end
