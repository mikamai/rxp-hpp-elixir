defmodule HppRequestTest do
  use ExUnit.Case
  import TestHelper

  test "build_hash with hpp_select_stored_card is overrides payer_ref" do
    request = %HppRequest{valid_hpp_request() | payer_ref: "newpayer1"}
    request2 = %HppRequest{
      valid_hpp_request() |
      payer_ref: "newpayer1", hpp_select_stored_card: "HPP_SELECT_STORED_CARD"
    }
    request_hash = HppRequest.build_hash("mysecret", request).sha1hash
    request2_hash = HppRequest.build_hash("mysecret", request2).sha1hash
    refute request_hash == request2_hash
  end

  test "build_hash with payer_ref and pmt_ref generates the correct hash" do
    request = %HppRequest{
      valid_hpp_request(true) |
      timestamp: "20130814122239",
      merchant_id: "thestore",
      order_id: "ORD453-11",
      amount: "29900",
      currency: "EUR",
      payer_ref: "newpayer1",
      pmt_ref: "mycard1"
    }
    request_hash = HppRequest.build_hash("mysecret", request).sha1hash
    assert request_hash == "4106afc4666c6145b623089b1ad4098846badba2"
  end

  test "build_hash without hpp_select_stored_card does not override payer_reference" do
    request = %HppRequest{valid_hpp_request() | payer_ref: "newpayer1"}
    request2 = %HppRequest{valid_hpp_request() | hpp_select_stored_card: ""}
    request_hash = HppRequest.build_hash("mysecret", request).sha1hash
    request2_hash = HppRequest.build_hash("mysecret", request2).sha1hash
    assert request_hash == request2_hash
  end

  test "with hpp_fraud_filter_mode produce a different hash" do
    request = %HppRequest{
      valid_hpp_request() |
      timestamp: "20130814122239",
      merchant_id: "thestore",
      order_id: "ORD453-11",
      amount: "29900",
      currency: "EUR",
      hpp_fraud_filter_mode: "ACTIVE"
    }
    request_hash = HppRequest.build_hash("mysecret", request).sha1hash
    assert request_hash == "b7b3cbb60129a1c169a066afa09ce7cc843ff1c1"
  end

  test "with same values produce always the same hash" do
    request = %HppRequest{
      valid_hpp_request() |
      timestamp: "20130814122239",
      merchant_id: "thestore",
      order_id: "ORD453-11",
      amount: "29900",
      currency: "EUR"
    }
    request_hash = HppRequest.build_hash("mysecret", request).sha1hash
    assert request_hash == "cc72c08e529b3bc153481eda9533b815cef29de3"
  end
end
