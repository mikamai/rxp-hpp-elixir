defmodule RxpHppTest do
  use ExUnit.Case
  import TestHelper
  doctest RxpHpp

  test "request_to_json parses correct" do
    expected_request = valid_hpp_request()
    json = RxpHpp.request_to_json "mysecret", expected_request
    converted_request = RxpHpp.request_from_json json, true
    expected_json = Poison.encode! HppRequestJsonWrappper.from_hpp_request(expected_request)
    actual_json   = Poison.encode! HppRequestJsonWrappper.from_hpp_request(converted_request)
    assert expected_json == actual_json
  end

  test "request_from_json encoded parses correct" do
    expected_request = valid_hpp_request()
    json = Poison.encode! json_wrapped_encoded_hpp_request()
    converted_request = RxpHpp.request_from_json json, true
    expected_json = Poison.encode! HppRequestJsonWrappper.from_hpp_request(expected_request)
    actual_json   = Poison.encode! HppRequestJsonWrappper.from_hpp_request(converted_request)
    assert expected_json == actual_json
  end

  test "request_from_json decoded parses correct" do
    expected_request =  json_wrapped_valid_hpp_request()
    input_json = Poison.encode! json_wrapped_valid_hpp_request()
    converted_request = RxpHpp.request_from_json input_json, false
    expected_json = Poison.encode!(expected_request)
    actual_json   = Poison.encode! HppRequestJsonWrappper.from_hpp_request(converted_request)
    assert expected_json == actual_json
  end

  test "response_to_json parses correct" do
    expected_response = valid_hpp_response()
    input_json  = RxpHpp.response_to_json "mysecret", expected_response
    converted_response = RxpHpp.response_from_json input_json, true
    expected_json = Poison.encode! HppResponseJsonWrappper.from_hpp_response(expected_response)
    actual_json   = Poison.encode! HppResponseJsonWrappper.from_hpp_response(converted_response)
    assert expected_json == actual_json
  end

  test "response_from_json encoded parses correct" do
    expected_response = json_wrapped_valid_hpp_response()
    input_json =  Poison.encode! json_wrapped_encoded_hpp_response()
    converted_response = RxpHpp.response_from_json input_json, true
    expected_json = Poison.encode! expected_response
    actual_json   = Poison.encode! HppResponseJsonWrappper.from_hpp_response(converted_response)
    assert expected_json == actual_json
  end
end
