defmodule RxpHpp.StructKeyMapper do
  alias RxpHpp.StructKeyMapper.Helper
  @moduledoc """
  Convert structs upcasing / downcasing the keys
  """

  @doc """
  Returns a struct trying to upcase all the keys

  """
  def from(origin, default) do
    origin
    |> Helper.keys
    |> Enum.reduce(
        default,
        fn (field, result) ->
          value = Map.get(origin, field)
          Map.put result, Helper.upcase_atom(field), value
        end
      )
  end

  @doc """
  Returns a struct trying to downcase all the keys
  """
  def to(origin, default) do
    origin
    |> Helper.keys
    |> Enum.reduce(
        default,
        fn (field, result) ->
          value = Map.get(origin, field)
          Map.put result, Helper.downcase_atom(field), value
        end
      )
  end
end
