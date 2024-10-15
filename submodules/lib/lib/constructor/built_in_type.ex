defmodule Lib.Constructor.BuiltInType do
  @ecto_types ~w(integer float decimal boolean string map binary any
    utc_datetime naive_datetime date time
    utc_datetime_usec naive_datetime_usec time_usec)a

  for ecto_type <- @ecto_types do
    def unquote(ecto_type)(value) do
      case Ecto.Type.cast(unquote(ecto_type), value) do
        {:ok, value} -> {:ok, value}
        :error -> {:error, "is not `#{Atom.to_string(unquote(ecto_type))}` type"}
      end
    end
  end

  def nonempty_string(value) do
    compose(value, [
      &string/1,
      &assert(String.trim(&1) != "", "cannot be empty")
    ])
  end


  def nonempty_uppercase_string(value) do
    format = ~r/^[A-Z_\s]*$/
    compose(value, [
      &string/1,
      &assert(String.trim(&1) != "", "cannot be empty"),
      &assert(String.length(&1) == 3, "must be 3 characters upper case alphabets"),
      &regex(&1, format),
    ])
  end

  def trimmed_string(value) do
    compose(value, [
      &string/1,
      &String.trim/1,
      &assert(&1 != "", "cannot be empty")
    ])
  end

  def pos_decimal(value) do
    compose(value, [&decimal/1, &assert(Decimal.gt?(&1, 0), "must be greater than 0")])
  end

  def non_neg_decimal(value) do
    compose(value, [
      &decimal/1,
      &assert(Decimal.compare(&1, 0) != :lt, "must be greater or equal to 0")
    ])
  end

  def json_map_string(value) do
    with {:ok, str} <- string(value) do
      case Jason.decode(str) do
        {:ok, decoded} when is_map(decoded) -> {:ok, Jason.encode!(decoded)}
        _ -> {:error, "invalid format"}
      end
    end
  end

  def enum(value, allow_strings) do
    if value in allow_strings do
      {:ok, value}
    else
      {:error, "must be one of [#{Enum.join(allow_strings, ",")}]"}
    end
  end

  def regex(value, format) do
    compose(value, [
      &string/1,
      &assert(&1 =~ format, "must be upper case alphabets")
    ])
  end

  defp assert(bool, error_msg) do
    if bool, do: :ok, else: {:error, error_msg}
  end

  defp compose(value, []), do: {:ok, value}

  defp compose(value, [fun | funs]) do
    case fun.(value) do
      {:error, error_msg} -> {:error, error_msg}
      {:ok, validated} -> compose(validated, funs)
      :ok -> compose(value, funs)
      validated -> compose(validated, funs)
    end
  end
end
