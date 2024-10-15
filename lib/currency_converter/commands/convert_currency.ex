defmodule CurrencyConverter.ConvertCurrency do
  use Lib.Constructor

  constructor do
    field :original_amount, :decimal, constructor: required(:pos_decimal)
    field :from_currency, :string, constructor: required(:nonempty_uppercase_string)
    field :to_currency, :string, constructor: required(:nonempty_uppercase_string)
  end

  @impl true
  def after_construct(%__MODULE__{} = request) do
    cond do
      request.from_currency == request.to_currency ->
        {:error, {:constructor, %{to_currency: "must not be same as `from_currency`"}}}

      true ->
        {:ok, request}
    end
  end

  defmodule CurrencyConversionResult do
    use Constructor

    constructor do
      field :original_amount, Decimal.t()
      field :from_currency, String.t()
      field :to_currency, String.t()
      field :converted_amount, Decimal.t()
      field :exchange_rate, Decimal.t()
      field :issued_at, DateTime.t()
    end
  end
end

defimpl CurrencyConverter.CommandHandler, for: CurrencyConverter.ConvertCurrency do
  alias CurrencyConverter.ConvertCurrency
  alias CurrencyConverter.ConvertCurrency.CurrencyConversionResult
  alias CurrencyConverter.CurrencyConversionRates
  alias Lib.Timestamp

  @spec execute(ConvertCurrency.t()) ::
          {:ok, CurrencyConversionResult.t()} | {:error, :unsupported_currency}
  def execute(%ConvertCurrency{
        from_currency: from_currency,
        to_currency: to_currency,
        original_amount: original_amount
      }) do
    with {:ok, exchange_rate} <-
           CurrencyConversionRates.get_exchange_rate(%{
             from_currency: from_currency,
             to_currency: to_currency
           }) do
      {:ok,
       CurrencyConversionResult.new(
         from_currency: from_currency,
         to_currency: to_currency,
         original_amount: original_amount,
         exchange_rate: exchange_rate,
         converted_amount:
           Decimal.mult(original_amount, exchange_rate) |> Decimal.round(2, :floor),
         issued_at: Timestamp.now()
       )}
    else
      {:error, :unsupported_currency} -> {:error, :unsupported_currency}
    end
  end
end
