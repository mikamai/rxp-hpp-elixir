defmodule HppRequestTest do
  use ExUnit.Case
  import TestHelper
  doctest Generator

  test "build_hash with hpp_select_stored_card is different" do
    request = %HppRequest{valid_hpp_request() | payer_ref: "newpayer1"}
    request2 = %HppRequest{valid_hpp_request() | payer_ref: "newpayer1", hpp_select_stored_card: "HPP_SELECT_STORED_CARD"}
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

    # context 'without hpp_select_stored_card' do
    #   let(:request2) { valid_hpp_request }

    #   before do
    #     subject.payer_ref = 'newpayer1'
    #     request2.hpp_select_stored_card = ''
    #   end

    #   it 'overrides payer_reference' do
    #     expect(subject.build_hash('mysecret').sha1hash).to eq request2.build_hash('mysecret').sha1hash
    #   end
    # end

    # context 'with hpp_fraud_filter_mode' do
    #   before do
    #     subject.timestamp             = '20130814122239'
    #     subject.merchant_id           = 'thestore'
    #     subject.order_id              = 'ORD453-11'
    #     subject.amount                = '29900'
    #     subject.currency              = 'EUR'
    #     subject.hpp_fraud_filter_mode = 'ACTIVE'
    #   end

    #   it 'produce a different hash' do
    #     expect(subject.build_hash('mysecret').sha1hash).to eq 'b7b3cbb60129a1c169a066afa09ce7cc843ff1c1'
    #   end
    # end

    # context 'with the same values' do
    #   before do
    #     subject.timestamp   = '20130814122239'
    #     subject.merchant_id = 'thestore'
    #     subject.order_id    = 'ORD453-11'
    #     subject.amount      = '29900'
    #     subject.currency    = 'EUR'
    #   end

    #   it 'produce always the same hash' do
    #     expect(subject.build_hash('mysecret').sha1hash).to eq 'cc72c08e529b3bc153481eda9533b815cef29de3'
    #   end
    # end
end
