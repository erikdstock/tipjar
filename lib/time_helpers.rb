module TimeHelpers
  # Get integer unix times for month
  # Currently this only supports integer year and month.
  # Maybe add DateTime Someday?
  # DateTime.new params: ([year=-4712[, month=1[, mday=1
  #                       [, hour=0[, minute=0[, second=0
  #                       [, offset=0[, start=Date::ITALY]]]]]]]])
  # @param {Fixnum} year defaults to this year
  # @param {Fixnum} month [required]
  # @return {Hash} with keys [1,-1] for first and last second of month
  def unix_month(month: nil, year: nil)
    year ||= DateTime.now.year
    result = {
      1 => unix_time(DateTime.new(year, month)),
      -1 => unix_time(DateTime.new(year, month, -1, -1, -1, -1))
    }
    result
  end

  # Convert a DateTime to unix time integer
  # @param {DateTime} date_time object
  # @return {Fixnum} unix time
  def unix_time(date_time)
    date_time.to_time.to_i
  end
end
