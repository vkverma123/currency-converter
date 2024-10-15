defmodule CurrencyConverterWeb.CurrencyConverterViewTest do
  use CurrencyConverterWeb.ViewCase, async: true

  import CurrencyConverter.Support.DecimalHelpers
  alias CurrencyConverter.ConvertCurrency.CurrencyConversionResult
  alias CurrencyConverterWeb.CurrencyConverterView

  test "should render show.json when currency conversion is done" do
    result = %CurrencyConversionResult{
      from_currency: "USD",
      to_currency: "THB",
      original_amount: ~d"89.91",
      converted_amount: ~d"2917.57",
      exchange_rate: ~d"32.45",
      issued_at: ~U[2024-11-11 03:03:03Z]
    }

    assert %{
             success: true,
             data: %{
               from_currency: "USD",
               to_currency: "THB",
               original_amount: "89.91",
               converted_amount: "2917.57",
               issued_at: "2024-11-11T03:03:03Z",
               exchange_rate: "32.45"
             }
           } =
             render(CurrencyConverterView, "show.json", %{
               result: {:ok, result}
             })
  end
end
