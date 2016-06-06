class User < ActiveRecord::Base
  include ListeningStats
  # Include default devise modules. Others available are:
  # devise :rememberable, :trackable, :validatable,
  # :confirmable, :lockable, :database_authenticatable, :registerable,
  # :recoverable,  :timeoutable and :omniauthable
  devise :omniauthable, omniauth_providers: [:lastfm]

  has_many :monthly_top_artists
  has_many :top_artists, through: :monthly_top_artists, class_name: 'Artist'

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
  # TODO should this overwrite the has_many method?
  # @param {DateTime} time object, only month/year matter
  # @param {Boolean} :force_update: update api whether data is stale or not.
  # @return {Array} collection of up-to-date artists for the month.
  def monthly_top_artists(time, force_update: false)
    # determine month and year
    # unless force_update is true:
    #   get monthly_top_artists for that time (raw sql where clause?)
    #   if monthly_top_artists is not empty
    #     AND last artist was updated in a month after requested month
    #     OR last artist was updated in the previous 24 hours TODO stupid feature?
    #     return current monthly top artists
    # else refesh monthly top artists and return
    current_top_artists = @monthly_top_artists
    return current_top_artists
    if current_top_artists.length > 0
    else
      # Get top artists for month
      # refreshed_top_artists = self.api_top_artists
    end
  end

end
