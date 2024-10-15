defmodule CurrencyConverterWeb.Router do
  use CurrencyConverterWeb, :router

  alias CurrencyConverterWeb.CurrencyConverterController

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/v1/api" do
    pipe_through :api

    get "/convert-currency", CurrencyConverterController, :convert_currency
  end
end
