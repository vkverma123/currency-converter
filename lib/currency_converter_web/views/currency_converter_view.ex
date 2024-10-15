defmodule CurrencyConverterWeb.CurrencyConverterView do
  use CurrencyConverterWeb, :view
  alias CurrencyConverter.ConvertCurrency.CurrencyConversionResult
  alias CurrencyConverter.Utils

  def render("show.json", %{result: {:ok, %CurrencyConversionResult{} = result}}) do
    %{
      success: true,
      data: %{
        from_currency: result.from_currency,
        to_currency: result.to_currency,
        exchange_rate: Utils.to_str(result.exchange_rate),
        original_amount: Utils.to_str(result.original_amount),
        converted_amount: Utils.to_str(result.converted_amount),
        issued_at: Utils.to_str(result.issued_at)
      }
    }
  end
end
