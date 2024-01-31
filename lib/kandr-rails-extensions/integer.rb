# frozen_string_literal: true

module KandrRailsExtensions
  module IntegerBoolean
    def to_bool
      !zero?
    end
  end

  # Ruby factorial functions
  module IntegerFactorial
    def factorial
      result = 1
      num = self
      self.times do
        result *= num
        num -= 1
      end
      result
    end

    def to_!
      factorial
    end
  end

  # Ruby termial functions
  module IntegerTermial
    def termial
      result = 0
      num = self
      self.times do
        result += num
        num -= 1
      end
      result
    end

    def to_?
      termial
    end
  end
end

# Add modifications to `Integer` class
class Integer
  include KandrRailsExtensions::IntegerBoolean
  include KandrRailsExtensions::IntegerFactorial
  include KandrRailsExtensions::IntegerTermial
end
