defmodule CurrencyConverterWeb.FallbackControllerTest do
  use ExUnit.Case
  import Phoenix.ConnTest
  alias CurrencyConverterWeb.FallbackController

  test "response error from constructor error" do
    error = {:constructor, %{field: "cannot be null"}}
    conn = FallbackController.call(build_conn(), {:error, error})
    body = json_response(conn, 400)

    assert body == %{
             "error" => %{
               "code" => "validation_error",
               "description" => %{"field" => "cannot be null"}
             },
             "success" => false
           }
  end
end
