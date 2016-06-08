class User < ActiveRecord::Base
  include ListeningStats

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
    time_range = UsersHelper.time_range_month(time)
    artists = current_top_artist(time_range)
    artists if !UsersHelper.month_end(time).future? && !artists.empty?
  end

  private

  def current_top_artist(time_range)
    MonthlyTopArtist.where(user_id: id, month: time_range)
    .joins(:artist)
    .select(UsersHelper.top_artist_attributes)
  end

end
