defprotocol Lib.ErrorTranslator do
  @type error :: atom() | {atom(), any()}
  @type status :: integer() | atom()
  @type body :: any()

  @spec translate(error :: error()) :: {status(), body()}
  def translate(error)
end

defimpl Lib.ErrorTranslator, for: Atom do
  def translate(:unsupported_currency), do: {404, "unsupported_currency"}
  def translate(:incorrect_password), do: {403, "incorrect_password"}
  def translate(:already_exists), do: {409, "already_exists"}

  def translate(_), do: {500, "internal_server_error"}
end

defimpl Lib.ErrorTranslator, for: Tuple do
  def translate({:constructor, %{} = errors}), do: {400, errors}
  def translate(_), do: {500, "internal_server_error"}
end

defimpl Lib.ErrorTranslator, for: Any do
  def translate(_), do: {500, "internal_server_error"}
end
