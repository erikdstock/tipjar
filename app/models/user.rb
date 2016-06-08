class User < ActiveRecord::Base
  include ListeningStats
  # Include default devise modules. Others available are:
  # devise :rememberable, :trackable, :validatable,
  # :confirmable, :lockable, :database_authenticatable, :registerable,
  # :recoverable,  :timeoutable and :omniauthable
  devise :omniauthable, omniauth_providers: [:lastfm]

  has_many :monthly_top_artists
  has_many :top_artists, through: :monthly_top_artists, source: :artist

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      # byebug
      user.password = Devise.friendly_token[0, 20]
      user.email     = auth.info.email
      user.name      = auth.info.name
      user.image     = auth.info.image # assuming the user model has an image
    end
  end

  # Get a User's top artists for a given month. Refreshes with the api only
  # if the stats may be out of date.
  # Loads artist data (name and image) along with MonthlyTopArtist model
  # so we have extra attributes: name and image
  # TODO should this overwrite the has_many method?
  # @param {DateTime} time object, only month/year matter
  # @param {Boolean} :force_update: update api whether data is stale or not.
  # @return {Array} collection of up-to-date artists for the month.
  def monthly_top_artists(time, force_refresh: false)
    year, month = time.year, time.month
    month_start = DateTime.new(year, month, 1).utc
    raise 'month is in the future' if month_start.future?

    month_end = DateTime.new(year, month, -1, -1, -1).utc
    unless force_refresh || month_end.future?
      time_range = month_start..month_end
      current_top_artists = MonthlyTopArtist.where(user_id: id, month: time_range).
        joins(:artist).select('artists.name, artists.image, month, play_count, user_id, artist_id, monthly_top_artists.updated_at')
      return current_top_artists unless current_top_artists.empty?
    end
    fresh_top_artists = refresh_top_artists
    fresh_top_artists
  end

end
