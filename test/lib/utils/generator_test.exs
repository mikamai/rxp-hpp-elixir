defmodule RxpHpp.GeneratorTest do
  use ExUnit.Case
  doctest RxpHpp.Generator

  test "timestamp is 14 digits" do
    assert Regex.match?(~r/[0-9]{14}/, RxpHpp.Generator.timestamp)
  end

  test "order_id is not nil" do
    refute RxpHpp.Generator.order_id == nil
  end
end
