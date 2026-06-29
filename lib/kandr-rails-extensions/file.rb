# frozen_string_literal: true

module KandrRailsExtensions
  module FileExists
    unless File.method_defined? :exists?
      def self.included(base)
        class << base
          # Add in support for original `exists?` method. Not using
          # `alias` so that the method's existance and origin are more clear.
          def exists?(filename)
            exist?(filename)
          end
        end
      end
    end
  end
end

# Add modifications to `File` class
class File
  include KandrRailsExtensions::FileExists
end
