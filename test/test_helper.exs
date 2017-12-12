ExUnit.start()

defmodule TestHelper do

  def valid_hpp_request(with_card_storage)do
    if with_card_storage do
      %HppRequest{valid_hpp_request() | card_storage_enable: "1", offer_save_card: "1"}
    else
      valid_hpp_request()
    end
  end

  def valid_hpp_request do
    %HppRequest{
      merchant_id: "MerchantID",
      account: "myAccount",
      order_id: "OrderID",
      amount: "100",
      currency: "EUR",
      timestamp: "20990101120000",
      sha1hash: "aafab12dd4f92e0d6e13dd8c3fce93232aedf28a",
      auto_settle_flag: "1",
      comment1: "a-z A-Z 0-9 ' \", + “” ._ - & \\ / @ ! ? % ( )* : £ $ & € # [ ] | = ;ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷ø¤ùúûüýþÿŒŽšœžŸ¥",
      comment2: "Comment Two",
      return_tss: "0",
      shipping_code: "56|987",
      shipping_co: "IRELAND",
      billing_code: "123|56",
      billing_co: "IRELAND",
      cust_num: "123456",
      var_ref: "VariableRef",
      prod_id: "ProductID",
      hpp_lang: "EN",
      card_payment_button: "Submit Payment",
      card_storage_enable: "0",
      offer_save_card: "0",
      payer_ref: "PayerRef",
      pmt_ref: "PaymentRef",
      payer_exist: "0",
      validate_card_only: "0",
      dcc_enable: "0"
    }
  end

  def json_wrapped_valid_hpp_request do
    request = HppRequestJsonWrappper.from_hpp_request valid_hpp_request()
    %HppRequestJsonWrappper{
      request |
      HPP_FRAUD_FILTER_MODE: nil,
      HPP_SELECT_STORED_CARD: nil,
      PAYER_REF: nil
    }
  end

  def encoded_hpp_request do
    %HppRequest{
      merchant_id: "TWVyY2hhbnRJRA==",
      account: "bXlBY2NvdW50",
      order_id: "T3JkZXJJRA==",
      amount: "MTAw",
      currency: "RVVS",
      timestamp: "MjA5OTAxMDExMjAwMDA=",
      sha1hash: "YWFmYWIxMmRkNGY5MmUwZDZlMTNkZDhjM2ZjZTkzMjMyYWVkZjI4YQ==",
      auto_settle_flag: "MQ==",
      comment1: "YS16IEEtWiAwLTkgJyAiLCArIOKAnOKAnSAuXyAtICYgXCAvIEAgISA/ICUgKCApKiA6IMKjICQgJiDigqwgIyBbIF0gfCA9IDvDgMOBw4LDg8OEw4XDhsOHw4jDicOKw4vDjMONw47Dj8OQw5HDksOTw5TDlcOWw5fDmMOZw5rDm8Ocw53DnsOfw6DDocOiw6PDpMOlw6bDp8Oow6nDqsOrw6zDrcOuw6/DsMOxw7LDs8O0w7XDtsO3w7jCpMO5w7rDu8O8w73DvsO/xZLFvcWhxZPFvsW4wqU=",
      comment2: "Q29tbWVudCBUd28=",
      return_tss: "MA==",
      shipping_code: "NTZ8OTg3",
      shipping_co: "SVJFTEFORA==",
      billing_code: "MTIzfDU2",
      billing_co: "SVJFTEFORA==",
      cust_num: "MTIzNDU2",
      var_ref: "VmFyaWFibGVSZWY=",
      prod_id: "UHJvZHVjdElE",
      hpp_lang: "RU4=",
      card_payment_button: "U3VibWl0IFBheW1lbnQ=",
      card_storage_enable: "MA==",
      offer_save_card: "MA==",
      payer_ref: "UGF5ZXJSZWY=",
      pmt_ref: "UGF5bWVudFJlZg==",
      payer_exist: "MA==",
      validate_card_only: "MA==",
      dcc_enable: "MA=="
    }
  end

  def json_wrapped_encoded_hpp_request do
    request = HppRequestJsonWrappper.from_hpp_request encoded_hpp_request()
    %HppRequestJsonWrappper{
      request |
      HPP_FRAUD_FILTER_MODE: nil,
      HPP_SELECT_STORED_CARD: nil,
      PAYER_REF: nil
    }
  end

  def valid_hpp_response do
    %HppResponse{
      merchant_id: "thestore",
      account: "myAccount",
      order_id: "ORD453-11",
      amount: "100",
      authcode: "79347",
      timestamp: "20130814122239",
      sha1hash: "c452c179d4d3aafd1ee409ee595c426ff0240e25",
      result: "00",
      message: "Successful",
      cvnresult: "1",
      pasref: "3737468273643",
      batchid: "654321",
      eci: "1",
      cavv: "123",
      xid: "654564564",
      comment1: "a-z A-Z 0-9 ' \", + “” ._ - & \\ / @ ! ? % ( )* : £ $ & € # [ ] | = ;ÀÁÂÃÄÅÆÇÈÉÊËÌÍÎÏÐÑÒÓÔÕÖ×ØÙÚÛÜÝÞßàáâãäåæçèéêëìíîïðñòóôõö÷ø¤ùúûüýþÿŒŽšœžŸ¥",
      comment2: "Comment Two"
    }
  end

  def json_wrapped_valid_hpp_response do
    HppResponseJsonWrappper.from_hpp_response valid_hpp_response()
  end

  def encoded_hpp_response do
    %HppResponse{
      merchant_id: "dGhlc3RvcmU=",
      account: "bXlBY2NvdW50",
      order_id: "T1JENDUzLTEx",
      amount: "MTAw",
      authcode: "NzkzNDc=",
      timestamp: "MjAxMzA4MTQxMjIyMzk=",
      sha1hash: "YzQ1MmMxNzlkNGQzYWFmZDFlZTQwOWVlNTk1YzQyNmZmMDI0MGUyNQ==",
      result: "MDA=",
      message: "U3VjY2Vzc2Z1bA==",
      cvnresult: "MQ==",
      pasref: "MzczNzQ2ODI3MzY0Mw==",
      batchid: "NjU0MzIx",
      eci: "MQ==",
      cavv: "MTIz",
      xid: "NjU0NTY0NTY0",
      comment1: "YS16IEEtWiAwLTkgJyAiLCArIOKAnOKAnSAuXyAtICYgXCAvIEAgISA/ICUgKCApKiA6IMKjICQgJiDigqwgIyBbIF0gfCA9IDvDgMOBw4LDg8OEw4XDhsOHw4jDicOKw4vDjMONw47Dj8OQw5HDksOTw5TDlcOWw5fDmMOZw5rDm8Ocw53DnsOfw6DDocOiw6PDpMOlw6bDp8Oow6nDqsOrw6zDrcOuw6/DsMOxw7LDs8O0w7XDtsO3w7jCpMO5w7rDu8O8w73DvsO/xZLFvcWhxZPFvsW4wqU=",
      comment2: "Q29tbWVudCBUd28"
    }
  end

  def json_wrapped_encoded_hpp_response do
    HppResponseJsonWrappper.from_hpp_response encoded_hpp_response()
  end
end
