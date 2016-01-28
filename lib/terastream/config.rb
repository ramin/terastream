module Terastream
  class Config
    attr_accessor :hostname, :username, :password, :timeout

    def initialize(options = {})
      @hostname = options[:hostname] if options[:hostname]
      @username = options[:username] if options[:username]
      @password = options[:password] if options[:password]
      @timeout = options[:timeout] || 240
    end
  end
end
