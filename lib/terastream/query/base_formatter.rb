module Terastream
  class Query
    class BaseFormatter
      def initialize(config = {})
        @config = config
      end

      def app(env)
        @app = env
      end
    end
  end
end
