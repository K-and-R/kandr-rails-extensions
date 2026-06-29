# frozen_string_literal: true

module KandrRailsExtensions
  # Add `false?` and `true?` to TrueClass
  module TrueTrue
    def false?
      false
    end

    def falsy?
      false?
    end

    def to_bool
      self
    end

    def true?
      true
    end

    def truthy?
      true?
    end
  end
end

# Add modifications to `TrueClass` class
class TrueClass
  include KandrRailsExtensions::TrueTrue
end
