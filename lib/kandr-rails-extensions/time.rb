module KandrRailsExtensions
  module TimeEpochTime
    alias_method :to_epoch, :to_i
    alias_method :to_posix, :to_i
    alias_method :to_unix, :to_i
  end

  module TimeMilliseconds
    def to_ms
      (self.to_f * 1000.0).to_i
    end
  end
end

class Time
  include KandrRailsExtensions::TimeEpochTime
  include KandrRailsExtensions::TimeMilliseconds
end
