defmodule RxpHpp.Request do
  alias RxpHpp.Common
  alias RxpHpp.Generator
  @moduledoc """
  Holds info for the Realex Hpp request.
  """

  defstruct(
    merchant_id: "",
    account: "",
    order_id: nil,
    amount: "",
    currency: "",
    timestamp: nil,
    sha1hash: "",
    auto_settle_flag: "",
    comment1: "",
    comment2: "",
    return_tss: "",
    shipping_code: "",
    shipping_co: "",
    billing_code: "",
    billing_co: "",
    cust_num: "",
    var_ref: "",
    prod_id: "",
    hpp_lang: "",
    card_payment_button: "",
    card_storage_enable: "",
    offer_save_card: "",
    payer_ref: "",
    pmt_ref: "",
    payer_exist: "",
    validate_card_only: "",
    dcc_enable: "",
    hpp_fraud_filter_mode: "",
    hpp_select_stored_card: ""
  )

  def build_hash(request, secret) do
    new_request = request
      |> generate_defaults
      |> set_payer_ref

    hash = new_request
      |> default_seed
      |> add_payer_ref_and_pmt_ref(new_request)
      |> add_fraud_filter_mode(new_request)

    %RxpHpp.Request{new_request | sha1hash: Generator.encode_hash(hash, secret)}
  end

  defp generate_defaults(%RxpHpp.Request{timestamp: timestamp, order_id: order_id} = request) do
    %RxpHpp.Request{
      request |
      timestamp: Common.value_or_default(timestamp, Generator.timestamp),
      order_id: Common.value_or_default(order_id, Generator.order_id)
    }
  end

  defp set_payer_ref(%RxpHpp.Request{hpp_select_stored_card: hpp_select_stored_card} = request) do
    if hpp_select_stored_card && hpp_select_stored_card != "" do
      %RxpHpp.Request{request| payer_ref: hpp_select_stored_card}
    else
      request
    end
  end

  defp add_fraud_filter_mode(hash_seed, %RxpHpp.Request{hpp_fraud_filter_mode: hpp_fraud_filter_mode}) do
    if hpp_fraud_filter_mode && hpp_fraud_filter_mode != "" do
      Enum.join [hash_seed, hpp_fraud_filter_mode], "."
    else
      hash_seed
    end
  end

  defp add_payer_ref_and_pmt_ref(hash_seed, %RxpHpp.Request{card_storage_enable: "1", payer_ref: payer_ref, pmt_ref: pmt_ref}) do
    payer_and_payment = [payer_ref || "", pmt_ref || ""]
    Enum.join [hash_seed, Enum.join(payer_and_payment, ".")], "."
  end

  defp add_payer_ref_and_pmt_ref(hash_seed, %RxpHpp.Request{hpp_select_stored_card: hpp_select_stored_card, payer_ref: payer_ref, pmt_ref: pmt_ref}) do
    if !hpp_select_stored_card || hpp_select_stored_card == "" do
      hash_seed
    else
      Enum.join [hash_seed, Enum.join([payer_ref || "", pmt_ref || ""], ".")], "."
    end
  end

  defp default_seed(%RxpHpp.Request{timestamp: timestamp, merchant_id: merchant_id, order_id: order_id, amount: amount, currency: currency}) do
    [
      timestamp,
      merchant_id,
      order_id,
      amount,
      currency
    ]
    |> Enum.map(&Common.value_or_default/1)
    |> Enum.join(".")
  end
end
