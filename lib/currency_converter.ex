defmodule CurrencyConverter do
  alias CurrencyConverter.ConvertCurrency
  alias CurrencyConverter.CommandHandler

  def convert_currency(from_currency, to_currency, amount) do
    with {:ok, command} <-
           ConvertCurrency.new(
             from_currency: from_currency,
             to_currency: to_currency,
             original_amount: amount
           ),
         {:ok, result} <- CommandHandler.execute(command) do
      {:ok, result}
    end
  end
end
