module TimeValidation
  def validate_time_in_past(time)
    raise 'month is in the future' if month_start(time).future?
  end

  def time_range_month(time)
    month_start(time)..month_end(time)
  end

  def month_start(time)
    DateTime.new(time.year, time.month, 1).utc
  end

  def month_end(time)
    DateTime.new(time.year, time.month, -1, -1, -1, -1).utc
  end

  # Time#to_i returns unix time in seconds
  # DateTime and Date need to be converted to time.
  # @return {Integer} unix epoch time
  def unix_time(time)
    time.to_time.to_i
  end
end
