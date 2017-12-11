defmodule HppResponseTest do
  use ExUnit.Case
  import TestHelper

  test "valid_hash? when relevant fields change" do
    validities = Enum.map(
      [:timestamp, :merchant_id, :order_id, :result, :message, :pasref, :authcode],
      fn(field) ->
        response = %HppResponse{
          valid_hpp_response() |
          sha1hash: HppResponse.generate_hash("mysecret", valid_hpp_response())
        }
        HppResponse.valid_hash? "mysecret", Map.put(response, field, "new")
      end
    )

    assert Enum.all?(validities, fn(validity) -> validity == false end)
  end

  test "valid_hash? when no relevants fields change" do
    response = %HppResponse{
      valid_hpp_response() |
      sha1hash: HppResponse.generate_hash("mysecret", valid_hpp_response()),
      cavv: "new"
    }
    validity = HppResponse.valid_hash? "mysecret", response
    assert validity
  end
end
