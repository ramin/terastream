require 'java'
require "terastream/version"

require "terastream/cli"
require "terastream/config"
require "terastream/connection"
require "terastream/errors"

require "terastream/query"
require "terastream/query/base_formatter.rb"
require "terastream/query/records_builder.rb"
require "terastream/query/result_set"
require "terastream/query/result_set_metadata"

require "terastream/middleware/formatters/csv_builder.rb"
require "terastream/middleware/formatters/json_builder.rb"
require "terastream/middleware/output/kafka.rb"
require "terastream/middleware/output/kinesis.rb"
require "terastream/middleware/output/redis.rb"
require "terastream/middleware/output/s3.rb"


require "terastream/jars/tdgssconfig.jar"
require "terastream/jars/terajdbc4.jar"

module Terastream
  class << self
    def new(options = {}, &block)
      connection = Connection.new(options)

      yield connection if block_given?
      connection
    end
  end
end
