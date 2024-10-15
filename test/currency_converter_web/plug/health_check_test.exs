defmodule CurrencyConverterWeb.Plug.HealthCheckTest do
  use CurrencyConverterWeb.ConnCase
  use Mimic
  alias CurrencyConverter.Repo
  alias CurrencyConverterWeb.Plug.HealthCheck

  describe "call/2" do
    test "should return conn with status 200 when service is healthy" do
      opts = [at: "/health-check"]
      conn = build_conn(:get, "/health-check")

      Repo
      |> stub(:status, fn -> :ok end)

      assert conn = HealthCheck.call(conn, opts)
      assert conn.halted
      assert %{"status" => "ok"} = json_response(conn, 200)
    end

    test "should return conn with status 500 when service is unhealthy" do
      opts = [at: "/health-check"]
      conn = build_conn(:get, "/health-check")

      Repo
      |> stub(:status, fn -> {:error, :something_wrong} end)

      assert conn = HealthCheck.call(conn, opts)
      assert conn.halted
      assert %{"status" => "error"} = json_response(conn, 500)
    end
  end
end
