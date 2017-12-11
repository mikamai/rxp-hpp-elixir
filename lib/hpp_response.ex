defmodule HppResponse do

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
end
