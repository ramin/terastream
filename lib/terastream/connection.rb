module Terastream
  class Connection
    attr_accessor :formatter, :output

    attr_reader :config

    def initialize(options = {})
      @config     = Config.new(options)
      @connection = nil
      @formatter  = Terastream::Query::RecordsBuilder.new
      @output     = nil
    end

    def connection
      @connection ||= get_connection
    end

    def create_statement
      connection.create_statement
    end

    def query(query_string)
      Query.build(self).execute(query_string)
    end

    # Config helpers
    def username=(username)
      config.username = username
    end

    def password=(password)
      config.password = password
    end

    def hostname=(hostname)
      config.hostname = hostname
    end

    def timeout=(timeout)
      config.timeout = timeout
    end

    private

    def get_connection
      java.sql.DriverManager.get_connection(connection_string, config.username, config.password)
    end

    def connection_string
      "jdbc:teradata://#{config.hostname}/tmode=TERA,autocommit=on,charset=UTF8,sessions=1"
    end
  end
end
