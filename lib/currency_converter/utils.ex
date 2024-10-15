defmodule CurrencyConverter.Utils do
  def to_str(nil), do: nil

  def to_str(%Decimal{} = d) do
    d |> Decimal.normalize() |> Decimal.to_string(:normal)
  end

  def to_str(%DateTime{} = d) do
    d |> DateTime.to_iso8601()
  end
end
