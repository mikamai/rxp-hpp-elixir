defmodule RxpHpp.ResponseJsonWrapper do
  @moduledoc """
    Used to wrap an RxpHpp.Response before being returned as JSON
  """
  defstruct(
    MERCHANT_ID: nil,
    ACCOUNT: nil,
    ORDER_ID: nil,
    AMOUNT: nil,
    AUTHCODE: nil,
    TIMESTAMP: nil,
    SHA1HASH: nil,
    RESULT: nil,
    MESSAGE: nil,
    CVNRESULT: nil,
    PASREF: nil,
    BATCHID: nil,
    ECI: nil,
    CAVV: nil,
    XID: nil,
    COMMENT1: nil,
    COMMENT2: nil,
    TSS: nil)
end
