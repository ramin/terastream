require "json"

module Terastream
  class JsonBuilder < Terastream::Query::BaseFormatter
    def call(&block)
      row_data = {}
      @app.headers.each_with_index do |header, index|
        row_data[header] = @app.record_set.getString(index + 1)
      end
      if block_given?
        yield row_data.to_json
      else
        row_data.to_json
      end
    end
  end
end
