
#Required if pensio_api library not in $LOAD_PATH
$:.unshift File.dirname(__FILE__)+ '/../lib/'

require 'httparty'
require 'pensio_api'

PensioAPI::Credentials.base_uri = 'https://testgateway.altapaysecure.com'
PensioAPI::Credentials.username = 'test_user'
PensioAPI::Credentials.password = 'password'

# Step 1 - generate a client-side session id
session_id  = "session-#{Time.now.to_i}"
shop_orderid = "checkout_session_#{Time.now.to_i}"

# Step 2 - create the checkout session
checkout_options = {
    'terminals'    => ['AltaPay Test Terminal'],
    'shop_orderid' => shop_orderid,
    'amount'       => 12.22,
    'currency'     => 'EUR',
    'type'         => 'payment',
    'session_id'   => session_id,
    'terminal'     => 'AltaPay Test Terminal'
}

checkout_response = PensioAPI::Ecommerce.checkout_session(checkout_options)

if checkout_response.success?
  puts "CheckoutSession created - SessionId: #{checkout_response.session_id} Status: #{checkout_response.session_status}"
else
  puts "CheckoutSession failed"
  exit 1
end
