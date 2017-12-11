defmodule RxpHpp do
  @moduledoc """
  Documentation for RxpHpp.
  """

  @doc """
  request to json.

  """
  def request_to_json(secret, hpp_request) do
    hpp_request
    |> HppRequest.build_hash(secret)
    |> HppEncodable.encode
    |> HppEncodable.to_json
  end

  def request_from_json(json_request, true) do
    json_request
    |> request_from_json(false)
    |> HppEncodable.decode
  end

  def request_from_json(json_request, false) do
    HppRequest.create_request json_request
  end

  def response_to_json(hpp_response, secret) do
    hpp_response
    |> HppResponse.build_hash(secret)
    |> HppEncodable.encode
    |> HppEncodable.to_json
  end

  def response_from_json(json_response, true) do
    json_response
    |> response_from_json(false)
    |> HppEncodable.decode
  end

  def response_from_json(json_response, false) do
    HppResponse.create_response json_response
    # TODO : add validate_response
  end
end
