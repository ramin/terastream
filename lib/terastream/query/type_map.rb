module Terastream
  class TypeMap
    class << self
      def map(value)
        if [1, -9, 12, -15, 91].include?(value)
          :getString
        else
          :getObject
        end
      end
    end
  end
end
