defmodule GeneratorTest do
  use ExUnit.Case
  doctest Generator

  test "timestamp is 14 digits" do
    assert Regex.match?(~r/[0-9]{14}/, Generator.timestamp)
  end

  test "order_id is not nil" do
    refute Generator.order_id == nil
  end
end
