defmodule CurrencyConverterWeb.FallbackController do
  use CurrencyConverterWeb, :controller
  alias Lib.ErrorTranslator

  def call(conn, {:error, error}) do
    {status, body} = ErrorTranslator.translate(error)

    conn
    |> put_status(status)
    |> json(render_error(body))
  end

  def call(conn, {:error, status, body}) do
    conn
    |> put_status(status)
    |> json(body)
  end

  defp render_error({:constructor, %{} = errors}) do
    %{
      "success" => false,
      "error" => %{
        "code" => "validation_error",
        "description" => errors
      }
    }
  end

  defp render_error(%Ecto.Changeset{} = changeset) do
    %{
      "success" => false,
      "error" => %{
        "code" => "validation_error",
        "description" =>
          Ecto.Changeset.traverse_errors(changeset, &translate_changeset_error/1)
          |> Map.new(fn {key, [error | _]} -> {key, error} end)
      }
    }
  end

  defp render_error(%{} = errors) do
    %{
      "success" => false,
      "error" => %{
        "code" => "validation_error",
        "description" => errors
      }
    }
  end

  defp render_error({error, description}) when is_atom(error) do
    %{
      "success" => false,
      "error" => %{"code" => error, "description" => description}
    }
  end

  defp render_error(error) when is_binary(error) do
    %{
      "success" => false,
      "error" => %{"code" => error}
    }
  end

  defp render_error(error) when is_atom(error) do
    render_error(Atom.to_string(error))
  end

  defp translate_changeset_error({msg, opts}) do
    Enum.reduce(opts, msg, fn {key, value}, acc ->
      String.replace(acc, "%{#{key}}", to_string(value))
    end)
  end
end
