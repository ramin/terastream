require 'redis'

module Terastream
  module Output
    class Redis
      def initialize(options = {})
        @connection = ::Redis.new
      end

      def <<(record)
        @connection.publish(:messages, record)
      end

      private

      def host
        @options["host"] || "localhost"
      end

      def port
        @options["port"] || "9092"
      end
    end
  end
end
