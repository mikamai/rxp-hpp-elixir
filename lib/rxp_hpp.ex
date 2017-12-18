defmodule RxpHpp do
  alias RxpHpp.Common
  alias RxpHpp.Request
  alias RxpHpp.Response
  alias RxpHpp.RequestJsonWrapper
  alias RxpHpp.ResponseJsonWrapper
  alias RxpHpp.Encodable
  alias RxpHpp.StructKeyMapper
  alias RxpHpp.StructKeyMapper.Helper
  @moduledoc """
  Allow to create / parse requests and response
  """

  @doc """
  Given an `RxpHpp.Request` and a secret returns its JSON base64 encoded form.
  """
  def request_to_json(hpp_request, secret) do
    hpp_request
    |> Request.build_hash(secret)
    |> Encodable.encode
    |> StructKeyMapper.map_struct_with_keys(RequestJsonWrapper, &Helper.upcase_atom/1)
    |> Poison.encode!
  end

  @doc """
  Returns a decoded `RxpHpp.Response` from a map.
  """
  def request_from_map(out_hpp_request, true) do
    out_hpp_request
    |> request_from_map(false)
    |> Encodable.decode
  end

  def request_from_map(out_hpp_request, false) do
    out_hpp_request
    |> Map.new(&Helper.atomize_key/1)
    |> Common.struct2(RequestJsonWrapper)
    |> StructKeyMapper.map_struct_with_keys(Request, &Helper.downcase_atom/1)
  end

  @doc """
  Given an RxpHpp.Response and a secret returns its JSON base64 encoded form.
  """
  def response_to_json(hpp_response, secret) do
    hpp_response
    |> Response.build_hash(secret)
    |> Encodable.encode
    |> StructKeyMapper.map_struct_with_keys(ResponseJsonWrapper, &Helper.upcase_atom/1)
    |> Poison.encode!
  end

  @doc """
  Returns a decoded `RxpHpp.Response` from a map.
  """
  def response_from_map(out_hpp_response, true) do
    out_hpp_response
    |> response_from_map(false)
    |> Encodable.decode
  end

  def response_from_map(out_hpp_response, false) do
    out_hpp_response
    |> Map.new(&Helper.atomize_key/1)
    |> Common.struct2(ResponseJsonWrapper)
    |> StructKeyMapper.map_struct_with_keys(Response, &Helper.downcase_atom/1)
  end
end
