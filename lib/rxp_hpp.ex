defmodule RxpHpp do
  alias RxpHpp.Request
  alias RxpHpp.Response
  alias RxpHpp.RequestJsonWrapper
  alias RxpHpp.ResponseJsonWrapper
  alias RxpHpp.Encodable
  alias RxpHpp.StructKeyMapper
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
    |> StructKeyMapper.from(%Request{})
    |> Poison.encode!
  end

  @doc """
  Returns a decoded `RxpHpp.Response` from its JSON rappresentation.
  """
  def request_from_json(out_hpp_request, true) do
    out_hpp_request
    |> request_from_json(false)
    |> Encodable.decode
  end

  def request_from_json(out_hpp_request, false) do
    out_hpp_request
    |> Poison.decode!(as: %RequestJsonWrapper{})
    |> StructKeyMapper.to(%Request{})
  end

  @doc """
  Given an RxpHpp.Response and a secret returns its JSON base64 encoded form.
  """
  def response_to_json(hpp_response, secret) do
    hpp_response
    |> Response.build_hash(secret)
    |> Encodable.encode
    |> StructKeyMapper.from(%Response{})
    |> Poison.encode!
  end

  @doc """
  Returns a decoded `RxpHpp.Response` from its JSON rappresentation.
  """
  def response_from_json(out_hpp_response, true) do
    out_hpp_response
    |> response_from_json(false)
    |> Encodable.decode
  end

  def response_from_json(out_hpp_response, false) do
    out_hpp_response
    |> Poison.decode!(as: %ResponseJsonWrapper{})
    |> StructKeyMapper.to(%Response{})
  end
end
