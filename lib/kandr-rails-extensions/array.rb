# frozen_string_literal: true

module KandrRailsExtensions
  # Averaging functionality
  module ArrayAverage
    def average(as_float = true)
      if as_float
        float_average
      else
        integer_average
      end
    end

    def integer_average
      (sum / count) unless empty?
    end

    def float_average
      (sum / count.to_f) unless empty?
    end
  end

  module ArrayIncludes
    def self.included(base)
      class << base
        # Add in support for a more grammatical `includes?` method. Not using
        # `alias` so that the method's existance and origin are more clear.
        def includes?(item)
          include?(item)
        end
      end

      # Do the instance method too. Not using `alias` so that the method's
      # existance and origin are more clear.
      def includes?(item)
        include?(item)
      end
    end
  end
end


# Add modifications to `Array` class
class Array
  include KandrRailsExtensions::ArrayAverage
  include KandrRailsExtensions::ArrayIncludes
end
