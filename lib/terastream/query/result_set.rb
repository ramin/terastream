require "forwardable"

module Terastream
  class Query
    class ResultSet
      include Enumerable

      extend Forwardable

      attr_accessor :record_set, :headers, :formatter, :results, :output

      def_delegators :@metadata, :column_count, :columns, :headers, :types

      def initialize(record_set, formatter = Terastream::JsonBuilder.new, destination = nil)
        @record_set = record_set
        @metadata = ResultSetMetadata.new(record_set)
        @formatter = formatter
        @output = destination || default_output
        @_results = nil
        @formatter.app(self)
      end

      def results
        @_results ||= build
      end

      def build
        if formatter.respond_to?(:init)
          @output << formatter.init
        end

        while row = @record_set.next
          @output << formatter.call
        end
        @output.send(:complete!) if @output.respond_to?(:complete!)
        @output if @output.instance_of?(Array)
      end

      def each(&block)
        results.each do |result|
          yield result
        end
      end

      private

      def default_output
        formatter.respond_to?(:default_output) ? formatter.default_output : []
      end
    end
  end
end
