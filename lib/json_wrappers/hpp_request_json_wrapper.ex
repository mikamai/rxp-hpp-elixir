defmodule HppRequestJsonWrappper do

  @derive {
    Poison.Encoder,
    except: [:HPP_FRAUD_FILTER_MODE, :HPP_SELECT_STORED_CARD, :PAYER_REF]
  }

  defstruct(
    MERCHANT_ID: nil,
    ACCOUNT: nil,
    ORDER_ID: nil,
    AMOUNT: nil,
    CURRENCY: nil,
    TIMESTAMP: nil,
    SHA1HASH: nil,
    AUTO_SETTLE_FLAG: nil,
    COMMENT1: nil,
    COMMENT2: nil,
    RETURN_TSS: nil,
    SHIPPING_CODE: nil,
    SHIPPING_CO: nil,
    BILLING_CODE: nil,
    BILLING_CO: nil,
    CUST_NUM: nil,
    VAR_REF: nil,
    PROD_ID: nil,
    HPP_LANG: nil,
    CARD_PAYMENT_BUTTON: nil,
    CARD_STORAGE_ENABLE: nil,
    OFFER_SAVE_CARD: nil,
    PAYER_REF: nil,
    PMT_REF: nil,
    PAYER_EXIST: nil,
    VALIDATE_CARD_ONLY: nil,
    DCC_ENABLE: nil,
    HPP_FRAUD_FILTER_MODE: nil,
    HPP_SELECT_STORED_CARD: nil)

  def from_hpp_request(hpp_request) do
    Enum.reduce(
      Helper.keys(hpp_request),
      %HppRequestJsonWrappper{},
      fn (field, hpp_request_json_wrapped) ->
        Map.put hpp_request_json_wrapped, Helper.upcase_atom(field), Map.get(hpp_request, field)
      end
    )
  end

  def to_hpp_request(hpp_request_json_wrapped) do
    Enum.reduce(
      Helper.keys(hpp_request_json_wrapped),
      %HppRequest{},
      fn (field, hpp_request) ->
        Map.put hpp_request, Helper.downcase_atom(field), Map.get(hpp_request_json_wrapped, field)
      end
    )
  end
end
