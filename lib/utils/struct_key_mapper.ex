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
    |> map_struct_and_key(default, &Helper.upcase_atom/1)
  end

  @doc """
  Returns a struct trying to downcase all the keys
  """
  def to(origin, default) do
    origin
    |> map_struct_and_key(default, &Helper.downcase_atom/1)
  end

  def map_struct_and_key(origin, default, func) do
    origin
    |> Helper.keys
    |> Enum.reduce(
        default,
        fn (field, result) ->
          Map.put result, func.(field), Map.get(origin, field)
        end
      )
  end
end
