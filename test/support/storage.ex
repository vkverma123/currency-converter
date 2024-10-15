defmodule CurrencyConverter.Storage do
  @doc """
  Clear the event store and read store databases
  """

  def reset! do
    reset_readstore()
  end

  defp reset_readstore do
    config = Application.get_env(:currency_converter, CurrencyConverter.Repo)

    {:ok, conn} = Postgrex.start_link(config)

    Postgrex.query!(conn, truncate_readstore_tables(), [])
  end

  defp truncate_readstore_tables do
    """
    TRUNCATE TABLE
      currency_conversion_rates
    RESTART IDENTITY
    CASCADE;
    """
  end
end
