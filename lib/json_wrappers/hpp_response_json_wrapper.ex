defmodule HppResponseJsonWrappper do

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

  def from_hpp_response(hpp_respose) do
    Enum.reduce(
      Helper.keys(hpp_respose),
      %HppResponseJsonWrappper{},
      fn (field, hpp_respose_json_wrapped) ->
        Map.put hpp_respose_json_wrapped, Helper.upcase_atom(field), Map.get(hpp_respose, field)
      end
    )
  end

  def to_hpp_response(hpp_response_json_wrapped) do
    Enum.reduce(
      Helper.keys(hpp_response_json_wrapped),
      %HppResponse{},
      fn (field, hpp_response) ->
        Map.put hpp_response, Helper.downcase_atom(field), Map.get(hpp_response_json_wrapped, field)
      end
    )
  end
end
