defmodule CurrencyConverterWeb.ErrorViewTest do
  use ExUnit.Case

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "should renders 404.json" do
    assert render(CurrencyConverterWeb.ErrorView, "404.json", []) == %{
             errors: %{detail: "Not Found"}
           }
  end

  test "should renders 500.json" do
    assert render(CurrencyConverterWeb.ErrorView, "500.json", []) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
