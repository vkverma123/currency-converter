ExUnit.start(
  capture_log: true,
  exclude: [:skip]
)

Mimic.copy(CurrencyConverter.CommandHandler)
Mimic.copy(CurrencyConverter)
Mimic.copy(CurrencyConverter.CurrencyConversionRates)
Mimic.copy(CurrencyConverter.Repo)
