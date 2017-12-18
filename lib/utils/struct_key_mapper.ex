defmodule RxpHpp.StructKeyMapper do
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
    |> Map.from_struct
    |> Map.new(fn {key, value} -> {func.(key), value} end)
  end
end
