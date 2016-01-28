require 'yaml'

module Terastream
  class CLI
    attr_accessor :config,
                  :file,
                  :hostname,
                  :username,
                  :password,
                  :query,
                  :timeout,
                  :formatter,
                  :output,
                  :output_options

    def initialize
      @config    = nil
      @file      = nil
      @formatter = "json"
      @hostname  = nil
      @output    = nil
      @password  = nil
      @query     = nil
      @timeout   = 10000
      @username  = nil
      @output_options = {}
    end

    def query_string
      @_query_string ||= build_query_string
    end

    def config_options
      @_config ||= read_config_file
    end

    def missing_query?
      query_string.nil?
    end

    def missing_hostname?
      hostname.nil?
    end

    def formatter_object
      formatter == "csv" ? Terastream::CSVBuilder.new : Terastream::JsonBuilder.new
    end

    def output_object
      case (output || "").to_sym
      when :redis
        Terastream::Output::Redis.new(config_for("redis"))
      when :kinesis
      when :kafka
        Terastream::Output::Kakfa.new(config_for("kafka"))
      else
        nil
      end
    end

    private

    def config_for(name)
      config_options.fetch(name, {})
    end

    def read_config_file
      if File.exists?(config.to_s)
        Yaml.read(config)
      else
        {}
      end
    end

    def build_query_string
      if query.nil? && file && File.exists?(file)
        File.read(file)
      else
        query
      end
    end
  end
end
