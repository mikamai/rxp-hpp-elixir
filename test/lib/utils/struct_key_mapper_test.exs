defmodule RxpHpp.StructKeyMapperTest do
  use ExUnit.Case
  import TestHelper
  alias RxpHpp.StructKeyMapper
  alias RxpHpp.StructKeyMapper.Helper
  alias RxpHpp.Response
  alias RxpHpp.ResponseJsonWrapper
  alias RxpHpp.Request
  alias RxpHpp.RequestJsonWrapper

  test "map_struct_with_keys transform an Request to a RxpHpp.RequestJsonWrapper" do
    hpp_request = valid_hpp_request()
    actual = StructKeyMapper.map_struct_with_keys(
      hpp_request,
      RequestJsonWrapper,
      &Helper.upcase_atom/1
    )
    expected = %RequestJsonWrapper{
      json_wrapped_valid_hpp_request() |
      HPP_FRAUD_FILTER_MODE: "",
      HPP_SELECT_STORED_CARD: "",
      PAYER_REF: "PayerRef"
    }
    assert actual == expected
  end

  test "map_struct_with_keys transform an Response to a RxpHpp.ResponseJsonWrapper" do
    hpp_response = valid_hpp_response()
    actual = StructKeyMapper.map_struct_with_keys(
      hpp_response,
      ResponseJsonWrapper,
      &Helper.upcase_atom/1
    )
    expected = json_wrapped_valid_hpp_response()
    assert actual == expected
  end

  test "map_struct_with_keys transform an RxpHpp.RequestJsonWrapper to an Request" do
    json_wrapped_hpp_request = json_wrapped_valid_hpp_request()
    actual = StructKeyMapper.map_struct_with_keys(
      json_wrapped_hpp_request,
      Request,
      &Helper.downcase_atom/1
    )
    expected = %Request{
      valid_hpp_request() |
      hpp_fraud_filter_mode: nil,
      hpp_select_stored_card: nil,
      payer_ref: nil
    }
    assert actual == expected
  end

  test "map_struct_with_keys transform an RxpHpp.ResponseJsonWrapper to a Response" do
    json_wrapped_hpp_response = json_wrapped_valid_hpp_response()
    actual = StructKeyMapper.map_struct_with_keys(
      json_wrapped_hpp_response,
      Response,
      &Helper.downcase_atom/1
    )
    expected = valid_hpp_response()
    assert actual == expected
  end
end
