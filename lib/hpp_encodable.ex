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

  defp apply_to_all(response, enc_func) do
    Enum.reduce(
      keys(response),
      response,
      fn(field, encoded_response) ->
        {_, result} = Map.get_and_update(
          encoded_response,
          field,
          fn(value) ->
            {value, enc_func.(value_or_empty(value))}
          end
         )
        result
      end
    )
  end
end
