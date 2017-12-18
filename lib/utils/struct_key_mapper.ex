defmodule RxpHpp.StructKeyMapper do
  alias RxpHpp.StructKeyMapper.Helper
  @moduledoc """
  Convert structs upcasing / downcasing the keys
  """

  @doc """
  Map a struct `origin` to another `base` applying `func` to each key
  """

  def map_struct_with_keys(origin, type, func) do
    struct type, map_keys(origin, func)
  end

  def map_keys(origin, func) do
    origin
    |> Helper.keys
    |> Enum.reduce(
        %{},
        fn (field, result) ->
          Map.put result, func.(field), Map.get(origin, field)
        end
      )
    end
end
