require "csv"

module Terastream
  class CSVBuilder < Terastream::Query::BaseFormatter
    def default_output(&block)
      CSV &block
    end

    def init
      @app.headers
    end

    def call(&block)
      row_data = []
      @app.headers.each_with_index do |header, index|
        row_data << @app.record_set.getString(index + 1)
      end
      row_data
    end
  end
end
