require 'openssl'

module LineItemsHelper
  def onpay_hash(gatewayid, currency, amount, reference, accepturl, declineurl)
    s = { onpay_accepturl: accepturl, onpay_amount: amount, onpay_currency: currency, onpay_declineurl: declineurl, onpay_gatewayid: gatewayid, onpay_reference: reference }
    s = s.to_query.downcase
    OpenSSL::HMAC.hexdigest("SHA1", '11cf0e2c6890e9ea399baff63d59e588a03517b0edaf3ae3d9badd7c0c579eacf385c8897542b2fdb46115fea3068f05c2730157b9cff1e9d48f692832a31a96', s)
  end
end
