class User < ActiveRecord::Base
  include ListeningStats

  devise :omniauthable, omniauth_providers: [:lastfm]

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.email     = auth.info.email
      user.name      = auth.info.name
      user.image     = auth.info.image
    end
  end

  def monthly_top_artists(time)
    time_range = time_range_month(time)
    artists = current_top_artist(time_range)
    artists if !month_end(time).future? && !artists.empty?
  end

  private

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

  def current_top_artist(time_range)
    MonthlyTopArtist.where(user_id: id, month: time_range).joins(:artist).select(
      <<-STRING
        artists.name,
        artists.image,
        month,
        play_count,
        user_id,
        artist_id,
        monthly_top_artists.updated_at
      STRING
    )
  end

end
