defmodule Lib.Constructor.BuiltInTypeTest do
  use ExUnit.Case

  import Lib.Constructor.BuiltInType

  describe "ecto types" do
    test "string/1" do
      assert {:ok, "string"} = string("string")
      assert {:ok, "   "} = string("   ")
      assert {:error, "is not `string` type"} = string(123)
    end

    test "integer/1" do
      assert {:ok, 0} == integer(0)
      assert {:ok, 1_000_000} == integer(1_000_000)
      assert {:ok, -10} == integer(-10)
      assert {:ok, 1} == integer("1")
      assert {:error, "is not `integer` type"} == integer("text")
    end

    test "decimal/1" do
      assert {:ok, dec} = decimal(Decimal.new("123.456789"))
      assert Decimal.eq?(dec, "123.456789")

      assert {:ok, dec} = decimal("123.456789")
      assert Decimal.eq?(dec, "123.456789")

      assert {:ok, dec} = decimal("123.456789E-2")
      assert Decimal.eq?(dec, "1.23456789")

      assert {:ok, dec} = decimal("1.23456789e2")
      assert Decimal.eq?(dec, "123.456789")

      assert {:ok, dec} = decimal(123.456789)
      assert Decimal.eq?(dec, "123.456789")

      assert {:ok, dec} = decimal(123)
      assert Decimal.eq?(dec, "123")

      assert {:error, "is not `decimal` type"} = decimal("not a decimal")
    end

    test "utc_datetime_usec/1" do
      assert {:ok, ~U[2020-05-05 00:00:00.000000Z]} ==
               utc_datetime_usec(~U[2020-05-05 00:00:00.000000Z])

      assert {:ok, ~U[2020-05-05 00:00:00.000000Z]} ==
               utc_datetime_usec("2020-05-05T00:00:00.000000Z")

      assert {:ok, ~U[2020-05-05 00:00:00.000000Z]} == utc_datetime_usec("2020-05-05 00:00:00")

      assert {:error, "is not `utc_datetime_usec` type"} == utc_datetime_usec("")
    end
  end

  test "nonempty_string/1" do
    assert {:ok, "this is not empty"} == nonempty_string("this is not empty")
    assert {:ok, " and not trimmed "} == nonempty_string(" and not trimmed ")
    assert {:error, "cannot be empty"} == nonempty_string("   ")
  end

  test "trimmed_string/1" do
    assert {:ok, "this is not empty"} == trimmed_string("this is not empty")
    assert {:ok, "and trimmed"} == trimmed_string(" and trimmed ")
    assert {:error, "cannot be empty"} == trimmed_string("   ")
  end

  test "pos_decimal/1" do
    assert {:ok, dec} = pos_decimal("123.456789")
    assert Decimal.eq?(dec, "123.456789")

    assert {:error, "must be greater than 0"} = pos_decimal("-123.456789")
    assert {:error, "must be greater than 0"} = pos_decimal("0")
  end

  test "non_neg_decimal/1" do
    assert {:ok, dec0} = non_neg_decimal("123.456789")
    assert Decimal.eq?(dec0, "123.456789")

    assert {:error, "must be greater or equal to 0"} = non_neg_decimal("-123.456789")

    assert {:ok, dec1} = non_neg_decimal("0")
    assert Decimal.eq?(dec1, "0")

    assert {:ok, dec2} = non_neg_decimal("-0")
    assert Decimal.eq?(dec2, "0")
  end

  test "json_map_string/1" do
    assert {:ok, ~s|{"a":"hello","b":17,"c":false}|} =
             json_map_string(~s|{"a": "hello", "b": 17, "c": false}|)

    assert {:ok, ~s|{}|} = json_map_string(~s|{}|)

    assert {:error, "invalid format"} = json_map_string("not_a_json_map")
    assert {:error, "invalid format"} = json_map_string("[1, 2, 3]")
  end

  test "enum/1" do
    assert {:ok, "abc"} = enum("abc", ~w(abc def))
    assert {:error, "must be one of [abc,def]"} = enum("hodl", ~w(abc def))
  end
end
