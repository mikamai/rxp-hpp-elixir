defmodule RxpHppTest do
  use ExUnit.Case
  import TestHelper
  alias RxpHpp.StructKeyMapper
  alias RxpHpp.RequestJsonWrapper
  alias RxpHpp.ResponseJsonWrapper
  doctest RxpHpp

  test "request_to_json parses correct" do
    expected_request = valid_hpp_request()
    json = RxpHpp.request_to_json expected_request, "mysecret"
    converted_request = RxpHpp.request_from_json json, true
    expected_json = Poison.encode! StructKeyMapper.from expected_request, %RequestJsonWrapper{}
    actual_json   = Poison.encode! StructKeyMapper.from converted_request, %RequestJsonWrapper{}
    assert expected_json == actual_json
  end

  test "request_from_json encoded parses correct" do
    expected_request = valid_hpp_request()
    json = Poison.encode! json_wrapped_encoded_hpp_request()
    converted_request = RxpHpp.request_from_json json, true
    expected_json = Poison.encode! StructKeyMapper.from expected_request, %RequestJsonWrapper{}
    actual_json   = Poison.encode! StructKeyMapper.from converted_request, %RequestJsonWrapper{}
    assert expected_json == actual_json
  end

  test "request_from_json decoded parses correct" do
    expected_request =  json_wrapped_valid_hpp_request()
    input_json = Poison.encode! json_wrapped_valid_hpp_request()
    converted_request = RxpHpp.request_from_json input_json, false
    expected_json = Poison.encode!(expected_request)
    actual_json   = Poison.encode! StructKeyMapper.from converted_request, %RequestJsonWrapper{}
    assert expected_json == actual_json
  end

  test "response_to_json parses correct" do
    expected_response = valid_hpp_response()
    input_json  = RxpHpp.response_to_json expected_response, "mysecret"
    converted_response = RxpHpp.response_from_json input_json, true
    expected_json = Poison.encode! StructKeyMapper.from expected_response, %ResponseJsonWrapper{}
    actual_json   = Poison.encode! StructKeyMapper.from converted_response, %ResponseJsonWrapper{}
    assert expected_json == actual_json
  end

  test "response_from_json encoded parses correct" do
    expected_response = json_wrapped_valid_hpp_response()
    input_json =  Poison.encode! json_wrapped_encoded_hpp_response()
    converted_response = RxpHpp.response_from_json input_json, true
    expected_json = Poison.encode! expected_response
    actual_json   = Poison.encode! StructKeyMapper.from converted_response, %ResponseJsonWrapper{}
    assert expected_json == actual_json
  end
end
