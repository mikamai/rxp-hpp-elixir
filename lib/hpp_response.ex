defmodule HppResponse do
  @moduledoc """
  Holds info for the Realex Hpp response.
  """

  defstruct(
    merchant_id: nil,
    account: nil,
    order_id: nil,
    amount: nil,
    authcode: nil,
    timestamp: nil,
    sha1hash: nil,
    result: nil,
    message: nil,
    cvnresult: nil,
    pasref: nil,
    batchid: nil,
    eci: nil,
    cavv: nil,
    xid: nil,
    comment1: nil,
    comment2: nil,
    tss: nil
  )

  def build_hash(response, secret) do
    %HppResponse{response | sha1hash: generate_hash(secret, response)}
  end

  def valid_hash?(secret, %HppResponse{sha1hash: sha1hash} = response) do
    generate_hash(secret, response) == sha1hash
  end

  def generate_hash(secret, %HppResponse{timestamp: timestamp, merchant_id: merchant_id, order_id: order_id, result: result, message: message, pasref: pasref, authcode: authcode}) do
    [
      timestamp,
      merchant_id,
      order_id,
      result,
      message,
      pasref,
      authcode
    ]
    |> Enum.map(&Helper.value_or_empty/1)
    |> Generator.encode_hash(secret)
  end
end
