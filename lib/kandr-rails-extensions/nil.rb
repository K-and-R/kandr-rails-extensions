module KandrRailsExtensions
  module NilCount
    def count
      nil
    end
  end

  module NilEmptyOrPresent
    def empty?
      true
    end

    def present?
      false
    end
  end
end

class NilClass
  include KandrRailsExtensions::NilCount
  include KandrRailsExtensions::NilEmptyOrPresent
end
