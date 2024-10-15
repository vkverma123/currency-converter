defmodule CurrencyConverter.Support.DecimalHelpers do
  defmacro sigil_d(str, _opts) do
    quote do
      Decimal.new(unquote(str))
    end
  end
end
