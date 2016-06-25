class User < ActiveRecord::Base
  include ListeningStats
  include TimeValidation

  devise :omniauthable, omniauth_providers: [:lastfm]

  has_many :monthly_top_artists
  has_many :top_artists, through: :monthly_top_artists, source: :artist

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0, 20]
      user.email     = auth.info.email
      user.name      = auth.info.name
      user.image     = auth.info.image
    end
  end

  def monthly_top_artists(time)
    validate_time_in_past(time)
    time_range = time_range_month(time)
    artists = current_top_artists(time_range)
    return artists if !artists.empty? && artists.all?(&:final?)
    artists = refresh_monthly_top_artists(time_range)
  end

  private

  # Refresh stale top artists
  # @param {Range} time range from #monthly_top_artists
  # @return {Collection} ActiveRecord Collection of [unsaved?] artists or false/raise?
  def refresh_monthly_top_artists(time_range)
    artists = fetch_api_top_artists(from: time_range.first, to: time_range.last)
    # TODO
    # Artists will be a hash, need to save each as an actual MTA
    # if artists can be saved, return artists, else return false
    # also clobber/update the old monthly top artists
  end

  def current_top_artists(time_range)
    MonthlyTopArtist.where(user_id: id, month: time_range).includes(:artist)
  end

  def top_artist_attributes
    [
      "artists.name",
      "artists.image",
      "month",
      "play_count",
      "user_id",
      "artist_id",
      "monthly_top_artists.updated_at"
    ].join(", ")
  end

end
