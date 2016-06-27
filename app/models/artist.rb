class Artist < ActiveRecord::Base
  has_many :monthly_top_artists
end
