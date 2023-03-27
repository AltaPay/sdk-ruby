module PensioAPI
  module Responses
    class Reservation < Transaction

      def each
        [reservation, charge, redirectUrl].each { |t| yield t }
      end

      def reservation
        @transactions.first
      end

      def charge
        @transactions.last
      end

      def redirectUrl
        @raw.has_key?('RedirectUrl') ? @raw['RedirectUrl'] : nil
      end

    end
  end
end
