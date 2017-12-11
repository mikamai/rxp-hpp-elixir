defmodule HppRequest do
  @moduledoc """
  Holds info for the Realex Hpp request.
  """
  defstruct(
    merchant_id: nil,
    account: nil,
    order_id: nil,
    amount: nil,
    currency: nil,
    timestamp: nil,
    sha1hash: nil,
    auto_settle_flag: nil,
    comment1: nil,
    comment2: nil,
    return_tss: nil,
    shipping_code: nil,
    shipping_co: nil,
    billing_code: nil,
    billing_co: nil,
    cust_num: nil,
    var_ref: nil,
    prod_id: nil,
    hpp_lang: nil,
    card_payment_button: nil,
    card_storage_enable: nil,
    offer_save_card: nil,
    payer_ref: nil,
    pmt_ref: nil,
    payer_exist: nil,
    validate_card_only: nil,
    dcc_enable: nil,
    hpp_fraud_filter_mode: nil,
    hpp_select_stored_card: nil
  )

  def build_hash(secret, request) do
    hash = request
      |> generate_defaults
      |> default_seed
      |> add_payer_ref_and_pmt_ref(request)
      |> add_fraud_filter_mode(request)
    %HppRequest{request | sha1hash: Generator.encode_hash(hash, secret)}
  end

  def generate_defaults(%HppRequest{timestamp: timestamp, order_id: order_id} = request) do
    %HppRequest{
      request |
      timestamp: if timestamp && timestamp != "" do
        timestamp
      else
        Generator.timestamp
      end,
      order_id: if order_id && order_id != "" do
        order_id
      else
        Generator.order_id
      end
    }
  end

  def add_fraud_filter_mode(hash_seed, %HppRequest{hpp_fraud_filter_mode: "1"} = request) do
    [hash_seed, request.hpp_fraud_filter_mode]
    |> Enum.join(".")
  end

  def add_fraud_filter_mode(hash_seed, _) do
    hash_seed
  end

  def add_payer_ref_and_pmt_ref(hash_seed, %HppRequest{card_storage_enable: "1", payer_ref: payer_ref, pmt_ref: pmt_ref} = request) do
    payer_and_payment = [payer_ref || "", pmt_ref || ""]
    Enum.join [hash_seed, Enum.join(payer_and_payment, ".")], "."
  end

  def add_payer_ref_and_pmt_ref(hash_seed, %HppRequest{hpp_select_stored_card: hpp_select_stored_card, payer_ref: payer_ref, pmt_ref: pmt_ref}) do
    if !hpp_select_stored_card || hpp_select_stored_card == "" do
      hash_seed
    else
      Enum.join [hash_seed, Enum.join([payer_ref || "", pmt_ref || ""], ".")], "."
    end
  end

  @doc """
  Creates a default seed given an HppRequest

  ## Examples
      iex> req = %HppRequest({timestamp: "12345678912345", merchant_id: "test"})
      iex> HppRequest.default_seed req
      "12345678912345.test..."
  """
  def default_seed(%HppRequest{timestamp: timestamp, merchant_id: merchant_id, order_id: order_id, amount: amount, currency: currency}) do
    [
      timestamp,
      merchant_id,
      order_id,
      amount,
      currency
    ]
    |> Enum.map(fn(x) -> x || "" end)
    |> Enum.join(".")
  end
end
