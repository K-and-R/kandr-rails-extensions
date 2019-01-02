# Add more extensions to Date beyond those provided by "active_support/core_ext/date"
class Date
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
        return !!(on_or_after?(start_date) && on_or_before?(end_date))
      when '(]'
        return !!(after?(start_date) && on_or_before?(end_date))
      when '[)'
        return !!(on_or_after?(start_date) && before?(end_date))
      when '()'
        return !!(after?(start_date) && before?(end_date))
      else
        return !!(after?(start_date) && before?(end_date))
    end
  end
end
