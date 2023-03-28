module PensioAPI
  module Responses
    class Reservation < Transaction
      attr_reader : redirect_url
      def each
        [reservation, charge, redirectUrl].each { |t| yield t }
      end

      def reservation
        @transactions.first
      end

      def charge
        @transactions.last
      end
      
      def redirect_url
        @redirect_url = @raw.has_key?('RedirectUrl') ? @raw['RedirectUrl'] : nil
      end

    end
  end
end
