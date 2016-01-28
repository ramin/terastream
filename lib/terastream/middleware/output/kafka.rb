require 'poseidon'

module Terastream
  module Output
    class Kafka
      def initialize(options = {})
        @options = options
        @connection = Poseidon::Producer.new([connection], producer)
      end

      def <<(record)
        @connection.send_messages [build_message(record)]
      end

      private

      def build_message(record)
        Poseidon::MessageToSend.new(topic, record)
      end

      def connection
        "#{host}:#{port}"
      end

      def host
        @options["host"] || "localhost"
      end

      def port
        @options["port"] || "9092"
      end

      def producer
        @options["producer"] || "terastream-producer"
      end

      def topic
        @options["topic"] || "terastream"
      end
    end
  end
end
