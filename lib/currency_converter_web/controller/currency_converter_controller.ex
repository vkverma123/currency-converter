defmodule CurrencyConverterWeb.CurrencyConverterController do
  use CurrencyConverterWeb, :controller

  action_fallback CurrencyConverterWeb.FallbackController

  def convert_currency(conn, params) do
    with {:ok, result} <-
           CurrencyConverter.convert_currency(
             params["from_currency"],
             params["to_currency"],
             params["original_amount"]
           ) do
      conn
      |> put_status(:ok)
      |> render("show.json", result: result)
    end
  end
end
