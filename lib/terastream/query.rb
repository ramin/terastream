module Terastream
  class Query
    attr_accessor :result_set, :statement

    class << self
      def build(connection)
        new(connection)
      end
    end

    def initialize(connection)
      @connection = connection
      @statement = connection.create_statement
      @statement.setQueryTimeout(connection.config.timeout)
      @executed = false
      @result_set = []
    end

    def executed?
      @executed
    end

    def execute(sql)
      results = ResultSet.new(statement.execute_query(sql), @connection.formatter, @connection.output)
      @executed = true
      results
    rescue  => e
      raise Terastream::Errors::QueryError.new("Database exception: #{e.message}")
    end
  end
end
