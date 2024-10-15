defmodule CurrencyConverterWeb.CurrencyConverterControllerTest do
  use CurrencyConverterWeb.ConnCase
  use Mimic

  import CurrencyConverter.Support.DecimalHelpers
  alias CurrencyConverter.ConvertCurrency
  alias CurrencyConverter.ConvertCurrency.CurrencyConversionResult
  alias CurrencyConverter.CommandHandler

  describe "convert_currency/2" do
    test "should return status 200 and render json content", %{conn: conn} do
      from_currency = "USD"
      to_currency = "THB"
      original_amount = ~d"89.91"

      CommandHandler
      |> expect(:execute, fn %ConvertCurrency{
                               from_currency: ^from_currency,
                               to_currency: ^to_currency,
                               original_amount: ^original_amount
                             } ->
        {:ok,
         CurrencyConversionResult.new(
           from_currency: from_currency,
           to_currency: to_currency,
           original_amount: original_amount,
           converted_amount: ~d"2917.25",
           exchange_rate: ~d"32.45",
           issued_at: ~U[2024-11-11 03:03:03Z]
         )}
      end)

      conn =
        get(conn, Routes.currency_converter_path(conn, :convert_currency), %{
          "from_currency" => from_currency,
          "to_currency" => to_currency,
          "original_amount" => original_amount
        })

      resp = json_response(conn, 200)

      assert resp == %{
               "data" => %{
                 "from_currency" => "USD",
                 "to_currency" => "THB",
                 "original_amount" => "89.91",
                 "converted_amount" => "2917.25",
                 "exchange_rate" => "32.45",
                 "issued_at" => "2024-11-11T03:03:03Z"
               },
               "success" => true
             }
    end

    test "should return status 404 for unsupported currency and render error", %{conn: conn} do
      from_currency = "USD"
      to_currency = "MMM"
      original_amount = ~d"89.91"

      params = %{
        "from_currency" => from_currency,
        "to_currency" => to_currency,
        "original_amount" => original_amount
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 404)

      assert resp == %{"error" => %{"code" => "unsupported_currency"}, "success" => false}
    end

    test "should return status 400 for invalid `to_currency_code` and render error", %{conn: conn} do
      from_currency = "USD"
      to_currency = "JHYH"
      original_amount = ~d"89.91"

      params = %{
        "from_currency" => from_currency,
        "to_currency" => to_currency,
        "original_amount" => original_amount
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 400)

      assert resp == %{
               "error" => %{
                 "code" => "validation_error",
                 "description" => %{"to_currency" => "must be 3 characters upper case alphabets"}
               },
               "success" => false
             }
    end

    test "should return status 400 for same currency conversion and render error", %{conn: conn} do
      from_currency = "USD"
      to_currency = "USD"
      original_amount = ~d"89.91"

      params = %{
        "from_currency" => from_currency,
        "to_currency" => to_currency,
        "original_amount" => original_amount
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 400)

      assert resp == %{
               "error" => %{
                 "code" => "validation_error",
                 "description" => %{"to_currency" => "must not be same as `from_currency`"}
               },
               "success" => false
             }
    end

    test "should return status 400 for zero original amount and render error", %{conn: conn} do
      from_currency = "USD"
      to_currency = "INR"
      original_amount = ~d"0"

      params = %{
        "from_currency" => from_currency,
        "to_currency" => to_currency,
        "original_amount" => original_amount
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 400)

      assert resp == %{
               "error" => %{
                 "code" => "validation_error",
                 "description" => %{"original_amount" => "must be greater than 0"}
               },
               "success" => false
             }
    end

    test "should return status 400 for invalid `to_currency` code and render error", %{conn: conn} do
      from_currency = "USD"
      to_currency = "inr"
      original_amount = ~d"89.91"

      params = %{
        "from_currency" => from_currency,
        "to_currency" => to_currency,
        "original_amount" => original_amount
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 400)

      assert resp == %{
               "error" => %{
                 "code" => "validation_error",
                 "description" => %{"to_currency" => "must be upper case alphabets"}
               },
               "success" => false
             }
    end

    test "should return status 400 for invalid `from_currency_code` and render error", %{
      conn: conn
    } do
      from_currency = "usd"
      to_currency = "INR"
      original_amount = ~d"89.87"

      params = %{
        "from_currency" => from_currency,
        "to_currency" => to_currency,
        "original_amount" => original_amount
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 400)

      assert resp == %{
               "error" => %{
                 "code" => "validation_error",
                 "description" => %{"from_currency" => "must be upper case alphabets"}
               },
               "success" => false
             }
    end

    test "should return status 400 for empty `from_currency_code` and render error", %{conn: conn} do
      from_currency = ""
      to_currency = "INR"
      original_amount = ~d"89.87"

      params = %{
        "from_currency" => from_currency,
        "to_currency" => to_currency,
        "original_amount" => original_amount
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 400)

      assert resp == %{
               "error" => %{
                 "code" => "validation_error",
                 "description" => %{"from_currency" => "cannot be empty"}
               },
               "success" => false
             }
    end

    test "should return status 400 for empty `to_currency_code` and render error", %{conn: conn} do
      from_currency = "USD"
      to_currency = ""
      original_amount = ~d"89.87"

      params = %{
        "from_currency" => from_currency,
        "to_currency" => to_currency,
        "original_amount" => original_amount
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 400)

      assert resp == %{
               "error" => %{
                 "code" => "validation_error",
                 "description" => %{"to_currency" => "cannot be empty"}
               },
               "success" => false
             }
    end

    test "should return status 400 for null `original_amount` and render error", %{conn: conn} do
      from_currency = "USD"
      to_currency = "INR"

      params = %{
        "from_currency" => from_currency,
        "to_currency" => to_currency
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 400)

      assert resp == %{
               "error" => %{
                 "code" => "validation_error",
                 "description" => %{"original_amount" => "cannot be null"}
               },
               "success" => false
             }
    end

    test "should return status 400 for invalid inputs and render error messages", %{conn: conn} do
      from_currency = 9
      to_currency = ""
      original_amount = "JDK"

      params = %{
        "from_currency" => from_currency,
        "to_currency" => to_currency,
        "original_amount" => original_amount
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 400)

      assert resp == %{
               "error" => %{
                 "code" => "validation_error",
                 "description" => %{
                   "original_amount" => "is not `decimal` type",
                   "from_currency" => "must be 3 characters upper case alphabets",
                   "to_currency" => "cannot be empty"
                 }
               },
               "success" => false
             }
    end

    test "should return status 400 for nil `from_currency_code` and nil `from_currency_code` and render error",
         %{conn: conn} do
      original_amount = ~d"89.87"

      params = %{
        "original_amount" => original_amount
      }

      conn = get(conn, Routes.currency_converter_path(conn, :convert_currency), params)

      resp = json_response(conn, 400)

      assert resp == %{
               "error" => %{
                 "code" => "validation_error",
                 "description" => %{
                   "from_currency" => "cannot be null",
                   "to_currency" => "cannot be null"
                 }
               },
               "success" => false
             }
    end
  end
end
