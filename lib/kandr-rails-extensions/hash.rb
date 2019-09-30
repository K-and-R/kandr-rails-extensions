require 'ostruct'

module KandrRailsExtensions
  module HashToOstruct
    # Recursively converts a `Hash` and all nested `Hash`es to
    # `OpenStruct`s. Especially useful for parsing YAML.
    #
    # ```
    # yaml=<<EOY
    #   subject: Programming Languages
    #   languages:
    #     - name : Ruby
    #       creator : Matz
    #     - name : Python
    #       creator : Guido van Rossum
    #     - name : Perl
    #       creator : Larry Wall
    # EOY
    # struct = YAML.load(yaml).to_ostruct
    # struct.subject
    # #=> "Programming Languages"
    # struct.languages.first
    # #=> #<OpenStruct name="Ruby", creator="Matz">
    # struct.languages.first.creator
    # #=> "Matz"
    # ```
    #
    def to_ostruct
      arr = map do |k, v|
        case v
          when Hash
            [k, v.to_ostruct]
          when Array
            [k, v.map { |el| el.respond_to?(:to_ostruct) ? el.to_ostruct : el }]
          else
            [k, v]
        end
      end
      OpenStruct.new(Hash[arr])
    end
  end

  module HashDrop
    # Like Hash#drop but works on (and returns) a copy hsh
    def drop *keys, &block
      self.clone.drop! *keys, &block
    end

    # Like Hash#delete but works on (and returns) hsh
    def drop! *keys
      if block_given?
        keys.each{ |key| delete(key) if yield self, key }
      else
        keys.each{ |key| delete key }
      end
      self
    end
  end
end

class Hash
  include KandrRailsExtensions::HashToOstruct
  include KandrRailsExtensions::HashDrop
end
