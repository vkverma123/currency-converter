defmodule CurrencyConverterWeb.ViewCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Mimic
      import Phoenix.View
    end
  end
end
