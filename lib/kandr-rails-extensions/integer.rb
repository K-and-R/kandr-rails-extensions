
module KandrRailsExtensions
  module IntegerFactorial
    # Ruby factorial function
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

  module IntegerTermial
    # Ruby termial function
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

class Integer
  include KandrRailsExtensions::IntegerFactorial
  include KandrRailsExtensions::IntegerTermial
end
