defmodule HppEncodableTest do
  use ExUnit.Case
  import TestHelper

  test "encode encodes properties" do
    encoded_order_id = HppEncodable.encode(valid_hpp_response()).order_id
    assert encoded_order_id == "T1JENDUzLTEx"
  end

  test "decode decodes properties" do
    encoded_order_id = HppEncodable.decode(encoded_hpp_response()).order_id
    assert encoded_order_id == "ORD453-11"
  end
end
