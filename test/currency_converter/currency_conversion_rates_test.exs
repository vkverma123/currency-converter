defmodule CurrencyConverter.CurrencyConversionRatesTest do
  use CurrencyConverter.DataCase
  alias CurrencyConverter.CurrencyConversionRates

  describe "get_exchange_rate/1" do
    test "should return exchange rate by from_currency and to_currency condition" do
      from_currency = "USD"
      to_currency = "THB"
      exchange_rate = "32.45"

      insert(
        :currency_conversion_rate,
        %{
          from_currency: from_currency,
          to_currency: to_currency
        }
      )

      assert {:ok, result} =
               CurrencyConversionRates.get_exchange_rate(%{
                 from_currency: from_currency,
                 to_currency: to_currency
               })

      assert Decimal.eq?(Decimal.new(exchange_rate), result)
    end

    test "should return error when `to_currency` not found" do
      from_currency = "USD"
      to_currency = "IOJ"

      assert {:error, :unsupported_currency} =
               CurrencyConversionRates.get_exchange_rate(%{
                 from_currency: from_currency,
                 to_currency: to_currency
               })
    end
  end
end
