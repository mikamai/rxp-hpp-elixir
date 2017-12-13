defmodule RxpHpp.Response do
  alias RxpHpp.Common
  alias RxpHpp.Generator

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
    %RxpHpp.Response{response | sha1hash: generate_hash(secret, response)}
  end

  def valid_hash?(secret, %RxpHpp.Response{sha1hash: sha1hash} = response) do
    generate_hash(secret, response) == sha1hash
  end

  def generate_hash(
                    secret,
                    %RxpHpp.Response{
                      timestamp: timestamp,
                      merchant_id: merchant_id,
                      order_id: order_id,
                      result: result,
                      message: message,
                      pasref: pasref,
                      authcode: authcode
                    }) do
    [
      timestamp,
      merchant_id,
      order_id,
      result,
      message,
      pasref,
      authcode
    ]
    |> Enum.map(&Common.value_or_default/1)
    |> Generator.encode_hash(secret)
  end
end
