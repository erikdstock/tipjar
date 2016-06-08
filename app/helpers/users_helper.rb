module UsersHelper
  extend self

  def validate_time(time)
    raise 'month is in the future' if month_start(time).future?
  end

  def time_range_month(time)
    validate_time(time)
    month_start(time)..month_end(time)
  end

  def month_start(time)
    DateTime.new(time.year, time.month, 1).utc
  end

  def month_end(time)
    DateTime.new(time.year, time.month, -1, -1, -1).utc
  end

  def top_artist_attributes
    <<-STRING
      artists.name,
      artists.image,
      month,
      play_count,
      user_id,
      artist_id,
      monthly_top_artists.updated_at
    STRING
  end

end
