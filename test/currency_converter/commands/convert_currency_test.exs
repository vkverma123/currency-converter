defmodule CurrencyConverter.ConvertCurrencyTest do
  use CurrencyConverter.DataCase
  use Mimic
  import CurrencyConverter.Support.DecimalHelpers
  alias CurrencyConverter.{CommandHandler, CurrencyConversionRates}
  alias CurrencyConverter.ConvertCurrency
  alias CurrencyConverter.ConvertCurrency.CurrencyConversionResult

  describe "ConvertCurrency.new/1" do
    test "should returns validated command" do
      params = [
        from_currency: "THB",
        to_currency: "USD",
        original_amount: "100.88"
      ]

      original_amount = Decimal.new("100.88")

      assert {:ok, validated_command} = ConvertCurrency.new(params)

      assert %ConvertCurrency{
               from_currency: "THB",
               original_amount: ^original_amount,
               to_currency: "USD"
             } = validated_command
    end

    test "should return error when validating command if `from_currency` and `to_currency` are same" do
      params = [
        from_currency: "THB",
        to_currency: "THB",
        original_amount: "100.88"
      ]

      assert {:error, validated_command} = ConvertCurrency.new(params)

      assert {:constructor, %{to_currency: "must not be same as `from_currency`"}} =
               validated_command
    end

    test "should return error when validating command if to_currency code is invalid" do
      params = [
        from_currency: "xyzbv",
        to_currency: "THB",
        original_amount: "100.88"
      ]

      assert {:error, validated_command} = ConvertCurrency.new(params)

      assert {:constructor, %{from_currency: "must be 3 characters upper case alphabets"}} =
               validated_command
    end

    test "should return error when validating command if original_amount is not more than zero" do
      params = [
        from_currency: "USD",
        to_currency: "THB",
        original_amount: "0"
      ]

      assert {:error, validated_command} = ConvertCurrency.new(params)

      assert {:constructor, %{original_amount: "must be greater than 0"}} = validated_command
    end
  end

  describe "execute(ConvertCurrency)" do
    test "should return Currency Conversion Result for supported currencies" do
      from_currency = "USD"
      to_currency = "THB"
      original_amount = ~d"89.9"
      converted_amount = ~d"2917.25"
      exchange_rate = ~d"32.45"

      CurrencyConversionRates
      |> expect(:get_exchange_rate, fn %{
                                         from_currency: ^from_currency,
                                         to_currency: ^to_currency
                                       } ->
        {:ok, exchange_rate}
      end)

      command =
        ConvertCurrency.new!(
          from_currency: from_currency,
          to_currency: to_currency,
          original_amount: original_amount
        )

      assert {:ok, {:ok, %CurrencyConversionResult{} = result}} = CommandHandler.execute(command)

      assert result.from_currency == from_currency
      assert result.to_currency == to_currency
      assert result.original_amount == original_amount
      assert result.converted_amount == converted_amount
      assert result.exchange_rate == exchange_rate
    end

    test "should return error for unsupported currencies" do
      from_currency = "USD"
      to_currency = "JHF"
      original_amount = ~d"445"

      CurrencyConversionRates
      |> expect(:get_exchange_rate, fn %{
                                         from_currency: ^from_currency,
                                         to_currency: ^to_currency
                                       } ->
        {:error, :unsupported_currency}
      end)

      command =
        ConvertCurrency.new!(
          from_currency: from_currency,
          to_currency: to_currency,
          original_amount: original_amount
        )

      assert {:error, :unsupported_currency} = CommandHandler.execute(command)
    end
  end
end
