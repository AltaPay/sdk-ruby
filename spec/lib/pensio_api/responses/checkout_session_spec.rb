require 'spec_helper'

describe PensioAPI::Responses::CheckoutSession do
  before :each do
    stub_pensio_response('/merchant/API/checkoutSession', 'checkout_session')
  end

  let(:response) do
    PensioAPI::Ecommerce.checkout_session(
      reservation_arguments.merge(terminals: ['AltaPay Test Terminal'])
    )
  end

  describe 'getter attributes' do
    describe '.session_id' do
      it 'exposes the session id' do
        expect(response.session_id).to eq('some-session-id')
      end
    end

    describe '.session_status' do
      it 'exposes the session status' do
        expect(response.session_status).to eq('CREATED')
      end
    end
  end

  context 'when the Body does not contain a Session element' do
    before :each do
      stub_pensio_response('/merchant/API/checkoutSession', 'create_payment_request')
    end

    it 'returns nil for the session attributes' do
      expect(response.session_id).to be_nil
      expect(response.session_status).to be_nil
    end
  end
end
