defmodule CurrencyConverter.CurrencyConversionRateFactory do
  alias CurrencyConverter.CurrencyConversionRate

  defmacro __using__(_opts) do
    quote do
      def currency_conversion_rate_factory do
        %CurrencyConversionRate{
          from_currency: "USD",
          to_currency: "THB",
          exchange_rate: Decimal.new("32.45")
        }
      end
    end
  end
end
