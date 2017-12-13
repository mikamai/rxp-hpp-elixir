defmodule RxpHpp.StructKeyMapperTest do
  use ExUnit.Case
  import TestHelper

  test "from transform an Request to a RxpHpp.RequestJsonWrapper" do
    hpp_request = valid_hpp_request()
    actual = RxpHpp.StructKeyMapper.from hpp_request, %RxpHpp.RequestJsonWrapper{}
    expected = %RxpHpp.RequestJsonWrapper{
      json_wrapped_valid_hpp_request() |
      HPP_FRAUD_FILTER_MODE: "",
      HPP_SELECT_STORED_CARD: "",
      PAYER_REF: "PayerRef"
    }
    assert actual == expected
  end

  test "from transform an Response to a RxpHpp.ResponseJsonWrapper" do
    hpp_response = valid_hpp_response()
    actual = RxpHpp.StructKeyMapper.from hpp_response, %RxpHpp.ResponseJsonWrapper{}
    expected = json_wrapped_valid_hpp_response()
    assert actual == expected
  end

  test "to transform an RxpHpp.RequestJsonWrapper to an Request" do
    json_wrapped_hpp_request = json_wrapped_valid_hpp_request()
    actual = RxpHpp.StructKeyMapper.to json_wrapped_hpp_request, %RxpHpp.Request{}
    expected = %RxpHpp.Request{
      valid_hpp_request() |
      hpp_fraud_filter_mode: nil,
      hpp_select_stored_card: nil,
      payer_ref: nil
    }
    assert actual == expected
  end

  test "to transform an RxpHpp.ResponseJsonWrapper to a Response" do
    json_wrapped_hpp_response = json_wrapped_valid_hpp_response()
    actual = RxpHpp.StructKeyMapper.to json_wrapped_hpp_response, %RxpHpp.Response{}
    expected = valid_hpp_response()
    assert actual == expected
  end
end
