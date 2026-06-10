require 'spec_helper'

describe PensioAPI::Ecommerce do
  before :each do
    stub_pensio_response('/merchant/API/createPaymentRequest', 'create_payment_request')
    stub_pensio_response('/merchant/API/createMultiPaymentRequest', 'create_multi_payment_request')
    stub_pensio_response('/merchant/API/checkoutSession', 'checkout_session')
  end

  describe '.create_payment_request' do
    let(:response) {PensioAPI::Ecommerce.create_payment_request(reservation_arguments.merge({timeout: 10}))}
    it 'returns an instance of PensioAPI::Responses::GatewayURL' do
      expect(PensioAPI::Request).to receive(:post).with("/merchant/API/createPaymentRequest",
                                                        {:basic_auth => {:username => "test_user", :password => "password"},
                                                         :headers => {
                                                             "Content-Type" => "application/x-www-form-urlencoded; charset=utf-8",
                                                             'x-altapay-client-version' => "RUBYSDK/#{PensioAPI::VERSION}",
                                                             'User-Agent' => "sdk-ruby/#{PensioAPI::VERSION}"
                                                         },
                                                         :body => {:terminal => "Pensio Test Terminal",
                                                                   :shop_orderid => "Test Payment",
                                                                   :amount => 123.45,
                                                                   :currency => "eur"},
                                                         :timeout => 10}).and_call_original
      expect(response).to be_an_instance_of(PensioAPI::Responses::GatewayURL)
    end
  end

  describe '.create_multi_payment_request' do
    let(:response) {PensioAPI::Ecommerce.create_multi_payment_request(reservation_arguments)}
    it 'returns an instance of PensioAPI::Responses::GatewayURL' do
      expect(response).to be_an_instance_of(PensioAPI::Responses::GatewayURL)
    end
  end

  describe '.checkout_session' do
    let(:options) do
      reservation_arguments.merge(
        terminals: ['AltaPay Test Terminal'],
        session_id: 'session-id-1',
        type: 'payment'
      )
    end
    let(:response) { PensioAPI::Ecommerce.checkout_session(options) }

    it 'returns an instance of PensioAPI::Responses::CheckoutSession' do
      expect(response).to be_an_instance_of(PensioAPI::Responses::CheckoutSession)
    end

    it 'posts to the checkoutSession endpoint with the supplied options' do
      expect(PensioAPI::Request).to receive(:post).with('/merchant/API/checkoutSession',
        {
          basic_auth: { username: 'test_user', password: 'password' },
          headers: {
            'Content-Type' => 'application/x-www-form-urlencoded; charset=utf-8',
            'x-altapay-client-version' => "RUBYSDK/#{PensioAPI::VERSION}",
            'User-Agent' => "sdk-ruby/#{PensioAPI::VERSION}"
          },
          body: {
            terminal: 'Pensio Test Terminal',
            shop_orderid: 'Test Payment',
            amount: 123.45,
            currency: 'eur',
            terminals: ['AltaPay Test Terminal'],
            session_id: 'session-id-1',
            type: 'payment'
          }
        }).and_call_original

      response
    end
  end
end
