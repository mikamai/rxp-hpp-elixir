defmodule RxpHpp do
  @moduledoc """
  Documentation for RxpHpp.
  """

  @doc """
  request to json.

  """
  def request_to_json(hpp_request, secret) do
    hpp_request
    |> HppRequest.build_hash(secret)
    |> HppEncodable.encode
    |> HppRequestJsonWrappper.from_hpp_request
    |> Poison.encode!
  end

  def request_from_json(json_wrapped_hpp_request, true) do
    json_wrapped_hpp_request
    |> request_from_json(false)
    |> HppEncodable.decode
  end

  def request_from_json(json_wrapped_hpp_request, false) do
    json_wrapped_hpp_request
    |> Helper.read_as(%HppRequestJsonWrappper{})
    |> HppRequestJsonWrappper.to_hpp_request
  end

  def response_to_json(hpp_response, secret) do
    hpp_response
    |> HppResponse.build_hash(secret)
    |> HppEncodable.encode
    |> HppResponseJsonWrappper.from_hpp_response
    |> Poison.encode!
  end

  def response_from_json(json_wrapped_hpp_response, true) do
    json_wrapped_hpp_response
    |> response_from_json(false)
    |> HppEncodable.decode
  end

  def response_from_json(json_wrapped_hpp_response, false) do
    json_wrapped_hpp_response
    |> Helper.read_as(%HppResponseJsonWrappper{})
    |> HppResponseJsonWrappper.to_hpp_response
  end
end
