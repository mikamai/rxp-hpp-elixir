defmodule RxpHppTest do
  use ExUnit.Case
  import TestHelper
  doctest RxpHpp

  test "request_to_json parses correct" do
    expected_request = valid_hpp_request()
    json = RxpHpp.request_to_json "mysecret", expected_request
    converted_request = RxpHpp.request_from_json json, true
    assert HppEncodable.to_json(expected_request) == HppEncodable.to_json(converted_request)
  end

  test "request_from_json encoded parses correct" do
    expected_request = valid_hpp_request()
    json = HppEncodable.to_json encoded_hpp_request()
    converted_request = RxpHpp.request_from_json json, true
    assert HppEncodable.to_json(expected_request) == HppEncodable.to_json(converted_request)
  end

  test "request_from_json decoded parses correct" do
    expected_request = valid_hpp_request()
    json = HppEncodable.to_json valid_hpp_request()
    converted_request = RxpHpp.request_from_json json, false
    assert HppEncodable.to_json(expected_request) == HppEncodable.to_json(converted_request)
  end

  test "response_to_json parses correct" do
  end

  test "response_from_json encoded" do
  end
end
