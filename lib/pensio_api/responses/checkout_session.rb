module PensioAPI
  module Responses
    class CheckoutSession < Base
      attr_reader :session_id, :session_status

      def initialize(request)
        super(request)

        session = @raw['Session'] || {}
        @session_id = session['Id']
        @session_status = session['Status']
      end
    end
  end
end
