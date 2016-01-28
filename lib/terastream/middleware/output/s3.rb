require "aws-sdk"
require "securerandom"

module Terastream
  module Output
    class S3
      attr_accessor :options

      def initialize(options = {})
        @options = options
        @temp = ""
        @connection = Aws::S3::Client.new(region: region)
        @records = []
      end

      def <<(record)
        @temp += record.is_a?(Hash) || record.is_a?(String) ? as_json(record) : as_csv(record)
      end

      def complete!
        tries = @max_retries
        begin
          @connection.put_object(
            key: options[:key],
            bucket: options[:bucket],
            body: @temp
          )
        rescue => e
          retries -= 1
          retry if tries > 0
        end
      end

      private

      def as_json(record)
        "#{record.to_json}\n"
      end

      def as_csv(record)
        CSV.generate{ |csv| csv << record }
      end

      def region
        options[:region] || ENV["region"] || "us-east-1"
      end
    end
  end
end
