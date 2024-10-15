defmodule CurrencyConverter.CurrencyConversionRates do
  alias CurrencyConverter.CurrencyConversionRate
  alias CurrencyConverter.Repo
  import Ecto.Query

  @spec get_exchange_rate(%{
          from_currency: String.t(),
          to_currency: String.t()
        }) :: {:ok, Decimal.t()} | {:error, :unsupported_currency}
  def get_exchange_rate(%{from_currency: from_currency, to_currency: to_currency}) do
    CurrencyConversionRate
    |> where([c], c.from_currency == ^from_currency and c.to_currency == ^to_currency)
    |> Repo.one()
    |> case do
      nil -> {:error, :unsupported_currency}
      %CurrencyConversionRate{exchange_rate: exchange_rate} -> {:ok, exchange_rate}
    end
  end
end
