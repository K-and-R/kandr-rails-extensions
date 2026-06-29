# frozen_string_literal: true

module KandrRailsExtensions
  # Add `true?` and `false? to FalseClass
  module FalseFalse
    def false?
      true
    end

    def falsy?
      false?
    end

    def to_bool
      self
    end

    def true?
      false
    end

    def truthy?
      true?
    end
  end
end

# Add modifications to `FalseClass` class
class FalseClass
  include KandrRailsExtensions::FalseFalse
end
