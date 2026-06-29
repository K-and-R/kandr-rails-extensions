# frozen_string_literal: true

module KandrRailsExtensions
  #  `String::to_bool`
  module StringBoolean
    def to_bool
      return true if truthy?
      return false if falsy?
      raise ArgumentError.new("invalid value for Boolean: \"#{self}\"")
    end

    def truthy?
      # self == true || self =~ (/^(true|t|yes|y|on|1)$/i)
      self == true || (self.present? && !falsy?)
    end

    def falsy?
      self == false || !!self.match(/^(false|f|no|n|off|0)$/i)
    end
  end

  #  `String::includes?`
  module StringIncludes
    def self.included(base)
      class << base
        # Add in support for a more grammatical `includes?` method. Not using
        # `alias` so that the method's existance and origin are more clear.
        def includes?(item)
          include?(item)
        end
      end
    end

    # Do the instance method too. Not using `alias` so that the method's
    # existance and origin are more clear.
    def includes?(item)
      include?(item)
    end
  end

  #  `String::blank?` and `String::present?`
  module StringPresent
    def blank?
      # Honor current Rails methods, if available
      if defined?(super)
        return super
      end
      !!self.match(/^\s*$/)
    end

    def present?
      # Honor current Rails methods, if available
      if defined?(super)
        return super
      end
      !blank?
    end
  end

  #  `String::slugify`
  module StringSlugify
    def slugify
      # strip the string
      ret = self.strip
      # blow away apostrophes
      ret.gsub!(/['`]/, '')
      # @ --> at, and & --> and
      ret.gsub!(/\s*@+\s*/, ' at ')
      ret.gsub!(/\s*&+\s*/, ' and ')
      # replace all non alphanumeric with underscore
      ret.gsub!(/\s*[^A-Za-z0-9]\s*/, '_')
      # convert double underscores to single
      ret.gsub!(/_+/, '_')
      # strip off leading/trailing underscore
      ret.gsub!(/\A[_\.]+|[_\.]+\z/, '')
      # lowercase
      ret.downcase
    end
  end

  #  `String::titleize`
  module StringTitleize
    # Overridding to support exclusions
    def titleize(options = {})
      exclusions = options.delete(:exclude)
      return super(options) if exclusions.blank?
      titleize_with_exclusions
    end

    def titleize_with_exclusions(options = {})
      exclusions = options.delete(:exclude)
      return titleize(options) if exclusions.blank?
      exclusions = [exclusions] unless exclusions.respond_to?(:join)
      self.underscore.humanize.gsub(
        /\b(['’`]?(?!(#{exclusions.join('|')})\b)[a-z])/
      ) { $&.capitalize }
    end
  end

  #  `String::trim`, and friends
  module StringTrim
    def trim(str=' ', count = nil)
      ltrim(str, count).rtrim(str, count)
    end

    def ltrim(str=' ', count = nil)
      trim_leading(str, count)
    end

    def rtrim(str=' ', count = nil)
      trim_trailing(str, count)
    end

    def trim_leading(str, count = nil)
      if count
        gsub!(/^#{str}{,#{count}}/,'') || self
      else
        gsub!(/^#{str}+/,'') || self
      end
    end

    def trim_trailing(str, count = nil)
      if count
        gsub!(/#{str}{,#{count}}$/,'') || self
      else
        gsub!(/#{str}+$/,'') || self
      end
    end
  end
end

# Add modifications to `String` class
class String
  include KandrRailsExtensions::StringBoolean
  include KandrRailsExtensions::StringIncludes
  include KandrRailsExtensions::StringPresent
  include KandrRailsExtensions::StringSlugify
  include KandrRailsExtensions::StringTitleize
  include KandrRailsExtensions::StringTrim
end
