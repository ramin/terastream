require "aws-sdk"

module Terastream
  module Output
    class Kinesis
      def initialize(options = {})
        @options = options || {}
        @connection = Aws::Kinesis::Client.new
        @max_retries = 4
      end

      def <<(record)
        put_record(record)
      end

      private

      def put_record(data)
        tries = @max_retries
        begin
          @connection.put_record(
            stream_name: @options[:stream_name],
            data: data,
            partition_key: partition_key
          )
        rescue => e
          tries -= 1
          retry if tries > 0
        end
      end

      def region
        options[:region] || ENV["region"]
      end

      def partition_key
        Time.now
      end
    end
  end
end
