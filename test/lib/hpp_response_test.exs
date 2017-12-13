defmodule RxpHpp.ResponseTest do
  use ExUnit.Case
  import TestHelper
  alias RxpHpp.Response

  test "valid_hash? when relevant fields change" do
    validities = Enum.map(
      [:timestamp, :merchant_id, :order_id, :result, :message, :pasref, :authcode],
      fn(field) ->
        response = %Response{
          valid_hpp_response() |
          sha1hash: Response.generate_hash("mysecret", valid_hpp_response())
        }
        Response.valid_hash? "mysecret", Map.put(response, field, "new")
      end
    )

    assert Enum.all?(validities, fn(validity) -> validity == false end)
  end

  test "valid_hash? when no relevants fields change" do
    response = %Response{
      valid_hpp_response() |
      sha1hash: Response.generate_hash("mysecret", valid_hpp_response()),
      cavv: "new"
    }
    validity = Response.valid_hash? "mysecret", response
    assert validity
  end
end
