# Add more extensions to Date beyond those provided by "active_support/core_ext/date"
module KandrRailsExtensions
  module DateCompare
    def before?(date, inclusive=false)
      !!(self < date) unless inclusive
      !!(self <= date)
    end

    def after?(date, inclusive=false)
      return !!(self > date) unless inclusive
      !!(self >= date)
    end

    def on_or_after?(date)
      after?(date, true)
    end

    def on_or_before?(date)
      before?(date, true)
    end

    def between?(start_date, end_date, inclusive='()')
      case inclusive
        when '[]'
          retval = (on_or_after?(start_date) && on_or_before?(end_date))
        when '(]'
          retval = (after?(start_date) && on_or_before?(end_date))
        when '[)'
          retval = (on_or_after?(start_date) && before?(end_date))
        when '()'
          retval = (after?(start_date) && before?(end_date))
        else
          retval = (after?(start_date) && before?(end_date))
      end
      retval
    end
  end
end

class Date; include KandrRailsExtensions::DateCompare; end
