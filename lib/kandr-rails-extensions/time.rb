# frozen_string_literal: true

module KandrRailsExtensions
  # Time methods for getting Unix timestamps.
  # Now, we already do have this in `to_i`, but it is less intuitive and
  # not as immediately obvious.
  module TimeEpochTime
    def to_epoch
      to_i
    end
    alias_method :to_posix, :to_epoch
    alias_method :to_unix, :to_epoch
  end

  # Get time in milliseconds, helpful for passing timestamps to JavaScript
  module TimeMilliseconds
    def to_ms
      (to_f * 1000.0).to_i
    end
  end
end

# Add modifications to `Time` class
class Time
  include KandrRailsExtensions::TimeEpochTime
  include KandrRailsExtensions::TimeMilliseconds
end
