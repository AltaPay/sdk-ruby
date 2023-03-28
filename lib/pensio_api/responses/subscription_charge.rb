module PensioAPI
  module Responses
    class SubscriptionCharge < Responses::Transaction
      extend Forwardable

      attr_reader : redirect_url
      def_delegators :new, :captured?

      def each
        [existing, new].each { |t| yield t }
      end

      def existing
        @transactions.first
      end

      def new
        @transactions.last
      end

      def redirect_url
        @redirect_url = @raw.has_key?('RedirectResponse') ? @raw['RedirectResponse']['Url'] : nil
      end
      
    end
  end
end
