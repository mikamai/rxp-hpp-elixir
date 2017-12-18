defmodule RxpHpp.Common do
  @moduledoc """
    Common helper methods
  """

  @doc """
  Returns value if not nil empty string otherwise

  ## Examples

      iex> RxpHpp.Common.value_or_default "test"
      "test"

      iex> RxpHpp.Common.value_or_default nil
      ""

  """
  def value_or_default(value, default \\ "") do
    value || default
  end
end
