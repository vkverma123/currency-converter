# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly
#
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias CurrencyConverter.CurrencyConversionRate
alias CurrencyConverter.Repo

[
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "THB",
    exchange_rate: Decimal.new("32.45")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "INR",
    exchange_rate: Decimal.new("80.45")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "EUR",
    exchange_rate: Decimal.new("0.94")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "GBP",
    exchange_rate: Decimal.new("0.82")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "JPY",
    exchange_rate: Decimal.new("149.32")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "AUD",
    exchange_rate: Decimal.new("1.57")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "CAD",
    exchange_rate: Decimal.new("1.36")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "CHF",
    exchange_rate: Decimal.new("0.91")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "CNY",
    exchange_rate: Decimal.new("7.31")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "HKD",
    exchange_rate: Decimal.new("7.84")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "NZD",
    exchange_rate: Decimal.new("1.68")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "SGD",
    exchange_rate: Decimal.new("1.37")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "ZAR",
    exchange_rate: Decimal.new("18.91")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "SEK",
    exchange_rate: Decimal.new("11.02")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "NOK",
    exchange_rate: Decimal.new("10.77")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "RUB",
    exchange_rate: Decimal.new("97.55")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "KRW",
    exchange_rate: Decimal.new("1340.33")
  },
  %CurrencyConversionRate{
    from_currency: "USD",
    to_currency: "BRL",
    exchange_rate: Decimal.new("5.04")
  },
  %CurrencyConversionRate{
    from_currency: "EUR",
    to_currency: "GBP",
    exchange_rate: Decimal.new("0.87")
  },
  %CurrencyConversionRate{
    from_currency: "EUR",
    to_currency: "JPY",
    exchange_rate: Decimal.new("158.90")
  },
  %CurrencyConversionRate{
    from_currency: "EUR",
    to_currency: "AUD",
    exchange_rate: Decimal.new("1.67")
  },
  %CurrencyConversionRate{
    from_currency: "GBP",
    to_currency: "INR",
    exchange_rate: Decimal.new("98.25")
  },
  %CurrencyConversionRate{
    from_currency: "GBP",
    to_currency: "JPY",
    exchange_rate: Decimal.new("181.85")
  },
  %CurrencyConversionRate{
    from_currency: "GBP",
    to_currency: "CAD",
    exchange_rate: Decimal.new("1.66")
  },
  %CurrencyConversionRate{
    from_currency: "CAD",
    to_currency: "INR",
    exchange_rate: Decimal.new("59.19")
  },
  %CurrencyConversionRate{
    from_currency: "AUD",
    to_currency: "JPY",
    exchange_rate: Decimal.new("94.92")
  },
  %CurrencyConversionRate{
    from_currency: "AUD",
    to_currency: "NZD",
    exchange_rate: Decimal.new("1.07")
  },
  %CurrencyConversionRate{
    from_currency: "AUD",
    to_currency: "THB",
    exchange_rate: Decimal.new("21.00")
  },
  %CurrencyConversionRate{
    from_currency: "JPY",
    to_currency: "KRW",
    exchange_rate: Decimal.new("8.97")
  },
  %CurrencyConversionRate{
    from_currency: "JPY",
    to_currency: "CNY",
    exchange_rate: Decimal.new("0.05")
  },
  %CurrencyConversionRate{
    from_currency: "CNY",
    to_currency: "INR",
    exchange_rate: Decimal.new("11.01")
  },
  %CurrencyConversionRate{
    from_currency: "CNY",
    to_currency: "THB",
    exchange_rate: Decimal.new("4.45")
  },
  %CurrencyConversionRate{
    from_currency: "KRW",
    to_currency: "THB",
    exchange_rate: Decimal.new("0.024")
  },
  %CurrencyConversionRate{
    from_currency: "BRL",
    to_currency: "INR",
    exchange_rate: Decimal.new("16.10")
  },
  %CurrencyConversionRate{
    from_currency: "BRL",
    to_currency: "MXN",
    exchange_rate: Decimal.new("3.50")
  },
  %CurrencyConversionRate{
    from_currency: "MXN",
    to_currency: "ZAR",
    exchange_rate: Decimal.new("1.08")
  },
  %CurrencyConversionRate{
    from_currency: "MXN",
    to_currency: "CLP",
    exchange_rate: Decimal.new("45.40")
  },
  %CurrencyConversionRate{
    from_currency: "NZD",
    to_currency: "SGD",
    exchange_rate: Decimal.new("0.82")
  },
  %CurrencyConversionRate{
    from_currency: "CHF",
    to_currency: "ZAR",
    exchange_rate: Decimal.new("20.89")
  },
  %CurrencyConversionRate{
    from_currency: "NOK",
    to_currency: "SEK",
    exchange_rate: Decimal.new("1.02")
  },
  %CurrencyConversionRate{
    from_currency: "RUB",
    to_currency: "INR",
    exchange_rate: Decimal.new("0.82")
  },
  %CurrencyConversionRate{
    from_currency: "ZAR",
    to_currency: "THB",
    exchange_rate: Decimal.new("1.69")
  },
  %CurrencyConversionRate{
    from_currency: "SGD",
    to_currency: "THB",
    exchange_rate: Decimal.new("24.21")
  },
  %CurrencyConversionRate{
    from_currency: "CHF",
    to_currency: "INR",
    exchange_rate: Decimal.new("89.03")
  },
  %CurrencyConversionRate{
    from_currency: "SEK",
    to_currency: "INR",
    exchange_rate: Decimal.new("7.21")
  }
]
|> Enum.each(&Repo.insert!/1)
