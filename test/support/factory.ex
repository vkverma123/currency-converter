defmodule CurrencyConverter.Factory do
  use ExMachina.Ecto, repo: CurrencyConverter.Repo

  use CurrencyConverter.CurrencyConversionRateFactory
end
