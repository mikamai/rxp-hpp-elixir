defmodule HppEncodable do
  @moduledoc """
  HppEncodable hold common behaviour applied
  to HppRequest and HppResponse structs.

  Includes: reading from json string, encoding and decoding
  """

  @doc """
  `encode` apply Base64 encoding to the given encodable struct

  ## Examples

      iex> request = %HppRequest{account: "myAccount"}
      iex> encoded_request = HppEncodable.encode(request)
      iex> %HppRequest{account: account} = encoded_request
      iex> account
      "bXlBY2NvdW50"
  """
  def encode(encodable) do
    encodable
    |> apply_to_all(&Base.encode64/1)
  end

  @doc """
  `decode` decode a Base64 encoded encodable struct

  ## Examples

      iex> request = %HppRequest{account: "bXlBY2NvdW50"}
      iex> decoded_request = HppEncodable.decode(request)
      iex> %HppRequest{account: account} = decoded_request
      iex> account
      "myAccount"
  """
  def decode(encodable) do
    encodable
    |> apply_to_all(&Base.decode64!(&1, padding: false))
  end

  defp apply_to_all(encodable, enc_func) do
    Enum.reduce(
      Helper.keys(encodable),
      encodable,
      fn(field, encoded_encodable) ->
        {_, result} = Map.get_and_update(
          encoded_encodable,
          field,
          fn
            value when value == nil -> {value, nil}
            value -> {value, enc_func.("#{value}")}
          end
         )
        result
      end
    )
  end
end
