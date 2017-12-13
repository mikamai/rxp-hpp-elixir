defmodule RxpHpp.RequestJsonWrapper do
  @moduledoc """
    Used to wrap an RxpHpp.Request before being returned as JSON
  """
  @derive {
    Poison.Encoder,
    except: [:HPP_FRAUD_FILTER_MODE, :HPP_SELECT_STORED_CARD, :PAYER_REF]
  }

  defstruct(
    MERCHANT_ID: "",
    ACCOUNT: "",
    ORDER_ID: "",
    AMOUNT: "",
    CURRENCY: "",
    TIMESTAMP: "",
    SHA1HASH: "",
    AUTO_SETTLE_FLAG: "",
    COMMENT1: "",
    COMMENT2: "",
    RETURN_TSS: "",
    SHIPPING_CODE: "",
    SHIPPING_CO: "",
    BILLING_CODE: "",
    BILLING_CO: "",
    CUST_NUM: "",
    VAR_REF: "",
    PROD_ID: "",
    HPP_LANG: "",
    CARD_PAYMENT_BUTTON: "",
    CARD_STORAGE_ENABLE: "",
    OFFER_SAVE_CARD: "",
    PAYER_REF: "",
    PMT_REF: "",
    PAYER_EXIST: "",
    VALIDATE_CARD_ONLY: "",
    DCC_ENABLE: "",
    HPP_FRAUD_FILTER_MODE: "",
    HPP_SELECT_STORED_CARD: "")
end
