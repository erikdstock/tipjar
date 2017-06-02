class DashboardController < ApplicationController
  # before_action :authenticate_user!

  # Load initial data for the dashboard [rendered in react]
  def main
    if current_user
      month = 1.month.ago
      artists = current_user.top_artists_for_month(month)
      formatted_artists = artists.map do |artist|
        {
          name: artist.artist.name,
          artist_id: artist.artist_id,
          play_count: artist.play_count,
          image: artist.artist.image,
          month: artist.month,
          give_to_url: artist.artist.give_to_url,
          give_to_verified: artist.artist.give_to_verified
        }
      end
      top_artists = [{
          month: format_month_year(month),
          artists: formatted_artists
        }]
      initial_data = { session: {jwt: current_user.jwt}, user: current_user.as_json, artistData: { artists: top_artists } }
    else
      initial_data = {}
    end
    load_initial_data(initial_data)
  end
end
