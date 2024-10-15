defmodule Lib.ConstructorTest do
  use ExUnit.Case

  describe "non-list" do
    defmodule TestSchema do
      use Lib.Constructor

      constructor do
        field :string, String.t(), constructor: required(:string)
        field :string_or_nil, String.t(), constructor: optional(:string)
        field :decimal, Decimal.t(), constructor: required(:decimal)
        field :decimal_or_nil, Decimal.t(), constructor: optional(:decimal)
        field :trimmed_string, String.t(), constructor: required(:trimmed_string)
        field :regex_with_opts, String.t(), constructor: required({:regex, ~r/^[a-z]+$/})
        field :enum, String.t(), constructor: required({:enum, ["a", "b"]})
      end
    end

    test "cast & validate" do
      params = %{
        "string" => "string",
        "string_or_nil" => nil,
        "decimal" => "17.181920",
        "decimal_or_nil" => "17.181920",
        "trimmed_string" => "  trimmed   ",
        "regex_with_opts" => "abc",
        "enum" => "a"
      }

      assert {:ok, %TestSchema{} = test_schema} = TestSchema.new(params)
      assert test_schema.string == "string"
      assert test_schema.string_or_nil == nil
      assert Decimal.eq?(test_schema.decimal, "17.181920")
      assert Decimal.eq?(test_schema.decimal_or_nil, "17.181920")
      assert test_schema.trimmed_string == "trimmed"
      assert test_schema.regex_with_opts == "abc"
      assert test_schema.enum == "a"
    end

    test "error" do
      params = %{
        "string" => nil,
        "string_or_nil" => 17,
        "decimal" => nil,
        "decimal_or_nil" => "not_a_decimal",
        "trimmed_string" => "     ",
        "regex_with_opts" => "123",
        "enum" => "z"
      }

      assert {:error, {:constructor, errors}} = TestSchema.new(params)

      assert %{
               string: "cannot be null",
               string_or_nil: "is not `string` type",
               decimal: "cannot be null",
               decimal_or_nil: "is not `decimal` type",
               trimmed_string: "cannot be empty",
               regex_with_opts: "invalid format",
               enum: "must be one of [a,b]"
             } = errors
    end
  end

  describe "list" do
    defmodule TestListSchema do
      use Lib.Constructor

      constructor do
        field :nil_to_empty_list, [String.t()], constructor: list_of(:string)
        field :empty_list_string, [String.t()], constructor: list_of(:string)
        field :list_of_any, [term()], constructor: list_of(:any)
        field :list_of_trimmed_string, [String.t()], constructor: list_of(:trimmed_string)
        field :list_of_regex_with_opts, [String.t()], constructor: list_of({:regex, ~r/^[a-z]+$/})
      end
    end

    test "cast & validate" do
      params = %{
        "nil_to_empty_list" => nil,
        "empty_list_string" => [],
        "list_of_any" => [1, "two", 3.0, true],
        "list_of_trimmed_string" => ["a", " b ", "  c  "],
        "list_of_regex_with_opts" => ["abc", "def"]
      }

      assert {:ok, %TestListSchema{} = test_schema} = TestListSchema.new(params)
      assert test_schema.nil_to_empty_list == []
      assert test_schema.empty_list_string == []
      assert test_schema.list_of_any == [1, "two", 3.0, true]
      assert test_schema.list_of_trimmed_string == ["a", "b", "c"]
    end

    test "error" do
      params = %{
        "nil_to_empty_list" => "not_a_list",
        "empty_list_string" => [17],
        "list_of_trimmed_string" => ["a", " b ", "    "],
        "list_of_regex_with_opts" => ["123", "456"]
      }

      assert {:error, {:constructor, errors}} = TestListSchema.new(params)

      assert %{
               nil_to_empty_list: "not a list",
               empty_list_string: "element in list is not `string` type",
               list_of_trimmed_string: "element in list cannot be empty",
               list_of_regex_with_opts: "element in list invalid format"
             } = errors
    end
  end

  describe "backward compatibility" do
    defmodule TestBackwardCompatSchema do
      use Lib.Constructor

      constructor do
        field :string_fun, String.t(), constructor: &__MODULE__.string_fun/1
      end

      def string_fun(value) when is_binary(value), do: {:ok, value}
      def string_fun(_), do: {:error, "must be a string"}
    end

    test "cast & validate" do
      params = %{
        "string_fun" => "hello"
      }

      assert {:ok, %TestBackwardCompatSchema{} = test_schema} =
               TestBackwardCompatSchema.new(params)

      assert test_schema.string_fun == "hello"
    end

    test "error" do
      params = %{
        "string_fun" => 17
      }

      assert {:error, {:constructor, errors}} = TestBackwardCompatSchema.new(params)

      assert %{string_fun: "must be a string"} = errors
    end
  end
end
