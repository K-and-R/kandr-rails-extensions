# frozen_string_literal: true

module KandrRailsExtensions
  # Nil `count` method (to avoid the `NoMethodError` on `nil`)
  module NilCount
    def count
      nil
    end

    def first
      nil
    end

    def last
      nil
    end
  end

  # Rails-style `blank?`, `empty?`, and `present?` methods for NilClass
  module NilEmptyOrPresent
    def empty?
      true
    end

    def present?
      !blank?
    end

    def blank?
      true
    end
  end

  # Boolean methods
  module NilBoolean
    def truthy?
      false
    end

    def true?
      false
    end

    def falsy?
      true
    end

    def false?
      false
    end

    def to_bool
      false
    end
  end
end

# Add modifications to `NilClass` class
class NilClass
  include KandrRailsExtensions::NilBoolean
  include KandrRailsExtensions::NilCount
  include KandrRailsExtensions::NilEmptyOrPresent
end
