defprotocol CurrencyConverter.CommandHandler do
  @spec execute(any) :: {:ok, any} | {:error, term}
  def execute(command)
end
