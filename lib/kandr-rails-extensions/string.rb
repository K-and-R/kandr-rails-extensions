class String
  def titleize(options = {})
    exclusions = options[:exclude]
    return ActiveSupport::Inflector.titleize(self) unless exclusions.present?
    self.underscore.humanize.gsub(/\b(['’`]?(?!(#{exclusions.join('|')})\b)[a-z])/) { $&.capitalize }
  end

  def slugify
    # strip the string
    ret = self.strip
    # blow away apostrophes
    ret.gsub!(/['`]/, "")
    # @ --> at, and & --> and
    ret.gsub!(/\s*@+\s*/, " at ")
    ret.gsub!(/\s*&+\s*/, " and ")
    # replace all non alphanumeric with underscore
    ret.gsub!(/\s*[^A-Za-z0-9]\s*/, '_')
    # convert double underscores to single
    ret.gsub!(/_+/, "_")
    # strip off leading/trailing underscore
    ret.gsub!(/\A[_\.]+|[_\.]+\z/, "")
    # lowercase
    ret.downcase
  end

  def trim(str=' ', count=nil)
    ltrim(str, count).rtrim(str, count)
  end

  def ltrim(str=' ', count=nil)
    trim_leading(str, count)
  end

  def rtrim(str=' ', count=nil)
    trim_trailing(str, count)
  end

  def trim_leading(str,count=nil)
    if count
      self.gsub!(/^#{str}{,#{count}}/,'') || self
    else
      self.gsub!(/^#{str}+/,'') || self
    end
  end

  def trim_trailing(str,count=nil)
    if count
      self.gsub!(/#{str}{,#{count}}$/,'') || self
    else
      self.gsub!(/#{str}+$/,'') || self
    end
  end
end
