require "ostruct"

module Terastream
  class Query
    class RecordsBuilder < Terastream::Query::BaseFormatter
      def call
        row_data = {}
        @app.headers.each_with_index do |header, index|
          row_data[header] = @app.record_set.getString(index + 1)
        end
        Record.new(row_data)
      end
    end

    class Record
      attr_reader :data

      def initialize(data = {})
        @data = OpenStruct.new(data)
      end

      def method_missing(name, *args, &block)
        if data.respond_to?(name)
          data.send(:name, *args, &block)
        else
          super
        end
      end
    end
  end
end
