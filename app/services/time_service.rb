module UnixTimeService
  def last_month(day = DateTime.now.day)
    now = DateTime.now
    last_month = now.month - 1
    last_month_length = DateTime.new(now.year, last_month, -1).day
    # This is crap.
    if day == :start
      day = 1
    elsif day == :end || (day.class == Fixnum && day > last_month_length)
      day = -1
    elsif day < 0 || day > 31
      throw ArgumentError.new('invalid target day')
    end

    unix_time(DateTime.new(now.year, last_month, day))
  end

  private

  def unix_time(date_time)
    date_time.to_time.to_i
  end
end
