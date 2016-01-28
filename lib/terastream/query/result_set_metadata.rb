module Terastream
  class Query
    class ResultSetMetadata
      def initialize(record_set)
        @metadata = record_set.getMetaData()
      end

      def column_count
        @column_count ||= @metadata.getColumnCount()
      end

      def columns
        @columns ||= extract_metadata
      end

      def headers
        @headers ||= columns.map{ |col| col[:name] }
      end

      def types
        @types ||= columns.map{ |col| col[:type] }
      end

      private

      def extract_metadata
        (1..column_count).inject([]) do |data, index|
          data << {
            name: @metadata.getColumnName(index),
            type: @metadata.getColumnType(index)
          }
          data
        end
      end
    end
  end
end
