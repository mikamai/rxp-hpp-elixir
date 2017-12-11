defmodule HppEncodable do

  def keys(encodable) do
    [_| actual_keys] = Map.keys encodable
    actual_keys
  end

  def value_or_empty(value) do
    value || ""
  end

  def encode(encodable) do
    encodable
    |> apply_to_all(&Base.encode64/1)
  end

  def decode(encodable) do
    encodable
    |> apply_to_all(&Base.decode64!(&1, padding: false))
  end

  def to_json(encodable) do
    {_, json} = encodable
      |> Map.from_struct
      |> Poison.encode
    json
  end

  defp apply_to_all(response, enc_func) do
    Enum.reduce(
      keys(response),
      response,
      fn(field, encoded_response) ->
        {_, result} = Map.get_and_update(
          encoded_response,
          field,
          fn
            value when value == nil -> {value, nil}
            value -> {value, enc_func.(value)}
          end
         )
        result
      end
    )
  end
end
