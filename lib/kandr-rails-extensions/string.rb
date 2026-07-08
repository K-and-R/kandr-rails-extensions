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
    # Override to support the :exclude option in addition to ActiveSupport options
    # (e.g. keep_id_suffix:). If :exclude is present and non-blank we use custom
    # logic that leaves excluded words alone. Otherwise we discard the option
    # and delegate to ActiveSupport via super.
    def titleize(*args, **kwargs)
      # Support both titleize(exclude: ...) and legacy titleize({ exclude: ... })
      exclude = nil
      if args.first.is_a?(Hash)
        opts = args.first.dup
        exclude = opts.delete(:exclude)
        kwargs = kwargs.merge(opts)
      else
        exclude = kwargs.delete(:exclude)
      end

      if exclude.present?
        return titleize_with_exclusions(exclude: exclude, **kwargs)
      end

      # No meaningful :exclude provided: fall back to ActiveSupport
      super(*args, **kwargs)
    end

    def titleize_with_exclusions(*args, **kwargs)
      # Normalize exclude from either calling convention
      exclude = nil
      if args.first.is_a?(Hash)
        opts = args.first.dup
        exclude = opts.delete(:exclude)
        kwargs = kwargs.merge(opts)
      else
        exclude = kwargs.delete(:exclude)
      end

      if exclude.blank?
        # throw it away and fall back to ActiveSupport
        return titleize(**kwargs)
      end

      exclusions = exclude.respond_to?(:join) ? exclude : [exclude]

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
  prepend KandrRailsExtensions::StringTitleize
  include KandrRailsExtensions::StringBoolean
  include KandrRailsExtensions::StringIncludes
  include KandrRailsExtensions::StringPresent
  include KandrRailsExtensions::StringSlugify
  include KandrRailsExtensions::StringTrim
end
