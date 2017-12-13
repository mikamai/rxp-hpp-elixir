defmodule RxpHpp.Generator do
  @moduledoc """
  Documentation for RxpHpp.Generator.
  """

  @doc """
  Encode an hash given a secret

  ## Examples

      iex> RxpHpp.Generator.encode_hash "test-seed", "test-secret"
      "b6da728dd749cb5f832faaeceb32199db9faf422"

  """
  def encode_hash(seed, secret) do
    [hex_encode(seed), secret]
    |> Enum.join(".")
    |> hex_encode

  end

  def timestamp do
    Timex.now
    |> Timex.format!("%Y%m%d%H%M%S", :strftime)
  end

  def order_id do
    SecureRandom.urlsafe_base64
  end

  def hex_encode input do
    :sha
    |> :crypto.hash(input)
    |> Base.encode16(case: :lower)
  end
end
